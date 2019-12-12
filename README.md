# Inputs

1. input file
2. refractive indices: csvs, frequencies in THz

# How to run

`cordouan_main(inputfile_path, t_smp, e_smp, t_ref, e_ref)`

# Functions

1. `load_input` loads input file and returns a structure containing relevant data. Also checks input for errors 

2. `fft_func` (or some other name)--takes two arguments-- vectors for E(t) and t-- and returns the Fourier transform

3. `disc_data` interpolates input data to match requested data spacing

4. `build_transfer_function` takes in layer information (defined in input file and the files it points to) and returns a function which takes two arguments: $n$ and $\omega$. The function returns the predicted transfer function at frequency $\omega$ assuming the unknown refractive index is $n$. 

   