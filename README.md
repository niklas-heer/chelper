# chelper
A small caddy helper script. WIP.

It helps you to update caddy with all the plugins you want and need. You can save which plugins are being used in a config file.
Also it helps you to fix common issues such as file permissions and systemd permissions.

## Usage
```
chelper [option...]
    -h, help           Displays help page.
    -u, update         Updates caddy with all the wanted plugins.
    -f, fix            Fixes systemd related issue with caddy.
```

## Todo

* [x] make install script
* [x] sperate plugin list to a yml file
* [x] use install script to setup yml file
* [ ] add option to edit yml file
