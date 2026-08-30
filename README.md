![SWTPM Docker Arch Logo](etc/banner.png)

SWTPM Docker Arch
=================

A ready-to-use Docker image for [**SWTPM**](https://github.com/stefanberger/swtpm), a software-based TPM 2.0 emulator, built on Arch Linux and installed directly from the official pacman repositories.


Usage
-----

Installing SWTPM-Docker-Arch
```sh
$ git clone https://github.com/SurendraS26/swtpm-arch-docker.git
$ cd swtpm-arch-docker
$ docker build -t swtpm-arch .
```

Connect using [`tpm2-tools`](https://github.com/tpm2-software/tpm2-tools):

```sh
$ tpm2_startup -T swtpm:host=127.0.0.1,port=2321 -c
$ tpm2_pcrread --tcti="swtpm:host=127.0.0.1,port=2321" sha256
```

TCTI configuration for TSS2:
```
swtpm:host=127.0.0.1,port=2321
```


Requirements
------------

- Docker
- `tpm2-tools` on the host


Acknowledgement
----------------

This image bundles [**SWTPM**](https://github.com/stefanberger/swtpm) and [**libtpms**](https://github.com/stefanberger/libtpms) (IBM Corporation, 3-Clause BSD), and is built on [**Arch Linux**](https://archlinux.org/), whose components carry their own respective open-source licenses.


License
-------

```
MIT License

Copyright (c) 2026 Surendra S

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
