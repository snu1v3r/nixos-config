# Nix-OS config
This repo is intended to provide a *Nix-OS* configuration system to setup various types of machines. It uses both *Flakes* and *HomeManager*.

## Inspiration
This repo is inspired by the setup created by *LibrePhoenix*. His repo can be found [here](https://github.com/librephoenix/nixos-config).

## Installation
Installation is possible with a few commands. It assumes an already working minimal configuration

First start a *nix-shell* with *Git* enabled:

```
nix-shell -p git
```

In that shell clone this repository:

```
git clone https://github.com/snu1v3r/nixos-config.git
```

Next change into the new directory:

```
cd nixos-config
```

Switch to the new configuration:

```
sudo nixos-rebuild switch --flake .
```



## Home-Manager
### Switching to *Home-Manager*
To switch to a *Home-Manager* configuration assuming a previously enabled *Flake* setup you can use the following command:

```
home-manager switch --flake .#nameofconfiguration
```


## Flakes
### Updating
For updating packages using *Flakes* you can use the following command from the directory where the `flake.lock` file is stored:

```
nix flake update
```

Next you have to rebuild the system using the following command from the directory where the `flake.lock` file is stored:

```
sudo nixos-rebuild switch --flake .#nameofconfiguration
```

Benefit of this is that you can switch back to the old `flake.lock` file by switching back to that file in the *Git* repo. Effectively rolling back a package update.


