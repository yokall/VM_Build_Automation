# Packer templates for Debian

### Overview

The repository contains templates for Debian that can create Vagrant boxes
using Packer.

## Current Boxes

64-bit boxes:

* Debian Wheezy 7.7 (64-bit), VMware 269MB/VirtualBox 202MB/Parallels 251MB
* Debian Wheezy 7.6 (64-bit), VMware 266MB/VirtualBox 214MB/Parallels 252MB
* Debian Wheezy 7.5 (64-bit), VMware 266MB/VirtualBox 202MB/Parallels 255MB
* Debian Squeeze 6.0.10 (64-bit), VMware 219MB/VirtualBox 156MB/Parallels 203MB

32-bit boxes:

* Debian Wheezy 7.7 (32-bit), VMware 266MB/VirtualBox 206MB/Parallels 250MB
* Debian Wheezy 7.6 (32-bit), VMware 269MB/VirtualBox 202MB/Parallels 250MB
* Debian Wheezy 7.5 (32-bit), VMware 269MB/VirtualBox 202MB/Parallels 250MB
* Debian Squeeze 6.0.10 (32-bit), VMware 225MB/VirtualBox 152MB/Parallels 197MB

## Building the Vagrant boxes

To build all the boxes, you will need VirtualBox, VMware Fusion, and
Parallels Desktop for Mac installed.

Parallels requires that the
[Parallels Virtualization SDK for Mac](http://ww.parallels.com/downloads/desktop)
be installed as an additional preqrequisite.

A GNU Make `Makefile` drives the process via the following targets:

    make        # Build all the box types (VirtualBox, VMware & Parallels)
    make test   # Run tests against all the boxes
    make list   # Print out individual targets
    make clean  # Clean up build detritus

### Proxy Settings

The templates respect the following network proxy environment variables
and forward them on to the virtual machine environment during the box creation
process, should you be using a proxy:

* http_proxy
* https_proxy
* ftp_proxy
* rsync_proxy
* no_proxy

### Tests

The tests are written in [Serverspec](http://serverspec.org) and require the
`vagrant-serverspec` plugin to be installed with:

    vagrant plugin install vagrant-serverspec

The `Makefile` has individual targets for each box type with the prefix
`test-*` should you wish to run tests individually for each box.

Similarly there are targets with the prefix `ssh-*` for registering a
newly-built box with vagrant and for logging in using just one command to
do exploratory testing.  For example, to do exploratory testing
on the VirtualBox training environmnet, run the following command:

    make ssh-box/virtualbox/debian76-nocm.box

Upon logout `make ssh-*` will automatically de-register the box as well.

### Makefile.local override

You can create a `Makefile.local` file alongside the `Makefile` to override
some of the default settings.  The variables can that can be currently
used are:

* CM
* CM_VERSION
* \<iso_path\>
* UPDATE

`Makefile.local` is most commonly used to override the default configuration
management tool, for example with Chef:

    # Makefile.local
    CM := chef

Changing the value of the `CM` variable changes the target suffixes for
the output of `make list` accordingly.

Possible values for the CM variable are:

* `nocm` - No configuration management tool
* `chef` - Install Chef
* `puppet` - Install Puppet
* `salt`  - Install Salt

You can also specify a variable `CM_VERSION`, if supported by the
configuration management tool, to override the default of `latest`.
The value of `CM_VERSION` should have the form `x.y` or `x.y.z`,
such as `CM_VERSION := 11.12.4`

The variable `UPDATE` can be used to perform OS patch management.  The
default is to not apply OS updates by default.  When `UPDATE := true`,
the latest OS updates will be applied.

Another use for `Makefile.local` is to override the default locations
for the Debian install ISO files.

For Debian, the ISO path variables are:

* DEBIAN77_AMD64
* DEBIAN76_AMD64
* DEBIAN75_AMD64
* DEBIAN6010_AMD64
* DEBIAN77_I386
* DEBIAN76_I386
* DEBIAN75_I386
* DEBIAN6010_I386

This override is commonly used to speed up Packer builds by
pointing at pre-downloaded ISOs instead of using the default
download Internet URLs:
`DEBIAN77_AMD64 := file:///Volumes/Debian/debian-7.7.0-amd64-DVD-1.iso`
