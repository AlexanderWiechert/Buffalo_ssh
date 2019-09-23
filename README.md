# Buffalo SSH

This document briefly describes how to enable SFTP/SSH  on your buffalo device.

There are two systems ipaddresses

* Desktop
  * `192.168.1.2`
* execute_cmd.sh
  * `192.168.1.1`


# Get Root

To get root on the device you can use `acp_commander.jar` command. You'll need a Java installation to do that.

Using `acp_commander.jar` you can execute commands on the execute_cmd.sh, as `root`. You just need to know the ipaddress of your execute_cmd.sh and the password for the `admin` user.

Add your details to the [execute_cmd.sh](execute_cmd.sh) script, then execute it like so:

    ./execute_cmd.sh $arguments

Please examine the root.sh script which will run a couple of commands

* root.sh
  * Change the `root` password to `YOURROOTPASSWORD`.
  >`This is the password you'll use for SSH only` The **admin** webgui login will remain unchanged.``
  * Enable SFTP/SSH support.
  * Stop & start the `sshd` server


Once you have root you can login to your execute_cmd.sh via SSH and run commands
interactively:

```
    alex ~ $ ssh root@192.168.1.1
    root@192.168.1.1's password:
```

## Install ipkg

```
cd /tmp
wget http://ipkg.nslu2-linux.org/feeds/optware/cs05q3armel/cross/stable/lspro-bootstrap_1.2-7_arm.xsh
sh ./lspro-bootstrap_1.2-7_arm.xsh
```

> **NOTE**: If this site disappears you can look at the `archive/` directory in this repository.

The `.xsh` script will boosttrap the system and install ipkg and wget.


## Install NFS

To get the (user-space) NFS-server you'll run:
```
# ipkg update
# ipkg install nfs-server
```
To configure your exports you need to edit the configuration file
`/opt/etc/exports`.  My example is this:

```
/mnt/array1/backups 192.168.1.2(rw,sync)
/mnt/array1/share   192.168.1.2(rw,sync)
```

You'll need to restart NFS:

```
/opt/etc/init.d/*nfs* stop
/opt/etc/init.d/*nfs* start
```

## Testing NFS

From a local system in your LAN, with IP `192.168.1.2`, you should now
be able to list those exports:

```
alex@desktop:~# showmount -e 192.168.1.28
Export list for 192.168.1.28:
/mnt/array1/share   192.168.1.2
/mnt/array1/backups 192.168.1.2
```

## Mounting NFS Shares

mkdir /home/alex/share
mount  -t nfs -o vers=2 192.168.1.28:/mnt/array1/share /home/alex/share

mkdir /home/alex/backups
mount  -t nfs -o vers=2 192.168.1.28:/mnt/array1/backups /home/alex/backups
