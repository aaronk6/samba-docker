## Docker Container for Samba

This image has been built from the official Samba source. This is useful if you need a newer Samba version than the one that is provided by your distribution.

## Usage

This image expects that you provide your own smb.conf. It won’t generate one for you. You’ll have to provide your own `etc` directory containting your `smb.conf`.

The following example assumes that your have a directory called `etc` in your current working directory. The `etc` directory contains your `smb.conf` file.

```
docker run -v "$PWD/etc:/usr/local/samba/etc" aaronk6/samba
```

Expected output:

```
smbd version 4.13.4 started.
Copyright Andrew Tridgell and the Samba Team 1992-2020
daemon_ready: daemon 'smbd' finished starting up and ready to serve connections
```

## Limitations

Note that this image will **not** run `nmbd`. It will only run `smbd`.
