Runtimes are noted to 3 decimal places

# NO CHANGES
Runtime with no changes to stencil.c or the Makefile:
1. 5.904 s | 2. 5.919 s | 3. 5.903 s | Avg: 5.909 s 

# ITERATION ORDER
Avg runtime before changing iteration order: 5.909 s
Runtime after switching from column-major to row-major iteration order
1. 4.516 s | 2. 4.516 s | 3. 4.522 s | Avg: 4.518 s
Improvement: ~1.391 s
This improves the runtime as the iteration order now matches the memory layout more closely

# COMPILER OPTIMISATION FLAGS
Avg runtime with no optimisation flags: 4.518 s
Runtime after adding -O1 flag:
1. 2.003 s | 2. 2.004 s | 3. 2.003 s | Avg: 2.003 s
Improvement from no optimisation flags: ~2.515 s

Runtime after changing -O1 flag to -O2 flag:
1. 1.999 s | 2. 2.000 s | 3. 2.002 s | Avg: 2.000 s 
Improvement from no optimisation flags: ~2.518 s
Improvement from -O1 flag: ~0.515 s

Runtime after changing -O2 flag to -O3 flag:
1. 1.785 s | 2. 1.784 s | 3. 1.785 s | Avg: 1.785 s
Improvement from no optimisation flags: ~2.733 s
Improvement from -O2 flag: ~0.215 s

Runtime after changing -O3 flag to -Ofast flag, with -mtune=native:
1. 1.781 s | 2. 1.785 s | 3. 1.785 s | Avg: 1.784 s
Improvement from no optimisation flags: ~2.734 s
Improvement from -O3 flag: ~0.001 s

There was little noticeable improvement with this change, as the -Ofast flag simply lets the compiler determine which of -O1, -O2, or -O3 is best. The -mtune=native flag, which lets the compiler optimise for the native chip the code runs on seems to have little effect, either.

# DATA PRECISION
Changing the image precision from a double to a single floating point number:
1. 1.782 s | 2. 1.783 s | 3. 1.783 s | Avg: 1.783 s
Improvement from double precision: ~0.001 s
While a minimal improvement, this optimisation can safely be done as the data used for the images never requires a precision greater than what can be encoded in 32 bits.

# `restrict` keyword
This keyword assures the compiler that pointer arguments to a function will not point to the same memory location, allowing it to access and manipulate the memory faster.
1. 1.7823 s | 2. 1.7812 s | 3. 1.7854 s | Avg: 1.783 s
No noticeable improvement

# Evaluate co-efficients and only calculate cell indentifier once
The cell indentifier `j + i * height` is repeated several times, so this has been extracted into its own variable, `tmp`, to ensure it is calculated only once. The cells with variations on `tmp` have one simple addition or subtraction operation performed on them to reach their cell.

The co-efficients have been evaluated from `3.0 / 5.0` to `0.6f` and from `0.5 / 5.0` to `0.1f`. The multiplication by `0.5 / 5.0` is also factorised out.

1. 1.7817 s | 2. 1.7804 s | 3. 1.7802 s | Avg: 1.781 s
Improvement: ~0.002 s
