# Nix-OS config
This repo is intended to provide a *Nix-OS* configuration system to setup various types of machines. It uses both *Flakes* and *HomeManager*.

## Inspiration
This repo is inspired by the setup created by *LibrePhoenix*. His repo can be found [here](https://github.com/librephoenix/nixos-config).

## Automatic Installation
Installation is possible with a few commands. It assumes an already working minimal configuration

First start a *nix-shell* with *Git* and *Curl* enabled:

```
nix-shell -p git curl
```

Next execute the installation script (this will clone the repository):

```
sh <(curl -L https://raw.githubusercontent.com/snu1v3r/nixos-config/main/install_nixos.sh)
```

## Manual Installation
First start a *nix-shell* with *Git* and *Curl* enabled:

```
nix-shell -p git curl
```

Next clone the repository: 
```
git clone https://github.com/snu1v3r/nixos-config.git
```

Next change into the new directory:

```
cd nixos-config
```

Switch to the new configuration:

```
sudo nixos-rebuild switch --flake .#system
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

## Yubi key
The current configuration also enables the option to use a *Yubi* key for authentication against `ssh` or `sudo`. After activation of the `flake.nix` the key needs to be added to the relevant user profile with the following command:

```bash
pamu2fcfg > ~/.config/Yubico/u2f_keys
```

For any additional backup keys for the same account execute the following command:

```bash
pamu2fcfg -n >> ~/.config/Yubico/u2f_keys
```

(The difference between the two commands is intentional and necessary)
