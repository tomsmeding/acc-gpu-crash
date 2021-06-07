Run `./test.sh` to build and test. This requires `cuda-memcheck`.

The first command in `test.sh` is `cabal build`; you can change the script to use `stack` if you so wish.

This uses the published version of Accelerate and accelerate-llvm on Hackage, without any changes.
