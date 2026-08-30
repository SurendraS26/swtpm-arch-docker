## swtpm-arch-docker

Arch Linux Docker image running a software TPM 2.0 (swtpm), installed via pacman.

### Intial setup
```bash
git clone https://github.com/SurendraS26/swtpm-arch-docker.git
cd swtpm-arch-docker
```

### Build

```bash
docker build -t swtpm-arch .
```

### Run

```bash
docker run -d --name swtpm-arch \
  -p 2321:2321 -p 2322:2322 \
  -v swtpm-arch-state:/var/lib/swtpm/tpmstate \
  swtpm-arch
```

### Connect (host)

```bash
export TPM2TOOLS_TCTI="swtpm:host=127.0.0.1,port=2321"
tpm2_startup -T swtpm:host=127.0.0.1,port=2321 -c
```

### Verify

```bash
tpm2_pcrread --tcti="swtpm:host=127.0.0.1,port=2321" sha256
```

### Requirements

- Docker
- `tpm2-tools` on the host

## References
Libtpms-based TPM emulator with socket, character device, and Linux CUSE interface.
<https://github.com/stefanberger/swtpm>

Docker image of the Software TPM Emulator (SWTPM).
<https://github.com/danieltrick/swtpm-docker>
## License

```MIT
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
