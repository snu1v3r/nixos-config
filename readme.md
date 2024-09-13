# Nix-OS config
This repo is intended to provide a *Nix-OS* configuration system to setup various types of machines. It uses both *Flakes* and *HomeManager*.

## Inspiration
This repo is inspired by the setup created by *LibrePhoenix*. His repo can be found [here](https://github.com/librephoenix/nixos-config).


## Flakes
### Updating
For updating packages using *Flakes* you can use the following command from the directory where the `flake.lock` file is stored:

```
nix flake update
```

Next you have to rebuild the system using the following command from the directory where the `flake.lock` file is stored:

```
sudo nixos-rebuild switch --flake .
```

Benefit of this is that you can switch back to the old `flake.lock` file by switching back to that file in the *Git* repo. Effectively rolling back a package update.



