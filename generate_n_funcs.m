function [geom_out] = generate_n_funcs(geom)
   geom_out = geom;
   for ii = 1:numel(geom)
       mat = geom(ii);
       %% make refractive index retrieval function
       assert(isnumeric(mat.n) | ischar(mat.n), 'refractive index must be number or string')
       
       % static refractive index
       if isnumeric(mat.n)
           geom_out(ii).n_func = @(w, n_solve) mat.n;
                
       % unknown refractive index (what we're solving for)
       elseif strcmp(mat.n, 'solve')
           geom_out(ii).n_func = @(f, n_solve) n_solve;
                
       % load values for refractive index 
       else
           assert(isfile(mat.n),...
               'Could not find refractive index file %s', mat.n)
           dat = importdata(mat.n);
           freq = dat(:,1);
           n = dat(:,2);
           if size(dat, 2) == 3
               % positive K corresponds to loss
               n = n-1i*dat(:,3);
           end
           geom_out(ii).n_func = @(f, n_solve) interp1(freq, n, f);
       end
       fprintf('%d. %0.2f um of material w n from %s\n', ii, mat.d, mat.n)
   end
end