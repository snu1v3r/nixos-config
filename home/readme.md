# Home directory
This directory contains all the home directories for the various users. Currently only a single user with the name `user` is used.


## NixOS versus standalone
This directory structure can be used in both a *NixOS* and in a *Stand-Alone* setup. In the case of the *NixOS* setup the configuration is controlled from running the *Flake* in the `root` directory. In a *Stand-Alone* configuration the *Flake* in this directory is used.


## Switching configuration

## Directory structure
Each user has its own directory. In this directory it's `default.nix` will be loaded for the specific machine. This file will reference the `default.nix` in the `core` directory. This `core` directory is common on all machines. After loading the `core` configuration it will load it's specific configuration for that machine.



