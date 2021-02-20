## Docker Container for Samba

This image has been built from the official Samba source. This is useful if you need a newer Samba version than the one that is provided by your distribution.

**Please read the “Limitations” section below to find out if it’s suitable for your usecase.**

## Usage

This image expects that you provide your own smb.conf. It won’t generate one for you. You’ll have to provide your own `etc` directory containting your `smb.conf`.

The following example assumes that your have a directory called `etc` in your current working directory. The `etc` directory contains your `smb.conf` file.

```
docker run -v "$PWD/etc:/usr/local/samba/etc" -e USER=your_username -e PASSWORD=your_password -p 445:445 aaronk6/samba
```

Expected output:

```
Adding user `your_username' ...
Adding new group `your_username' (1000) ...
Adding new user `your_username' (1000) with group `your_username' ...
Creating home directory `/home/your_username' ...
Copying files from `/etc/skel' ...
Added user your_username.
smbd version 4.13.4 started.
Copyright Andrew Tridgell and the Samba Team 1992-2020
daemon_ready: daemon 'smbd' finished starting up and ready to serve connections
```

## Limitations

* Only one user is supported at the moment (will be created based on provided environment variables `$USER` and `$PASSWORD`)
* This image will **not** run `nmbd`. It will only run `smbd`.
