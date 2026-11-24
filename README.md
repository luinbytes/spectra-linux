# Spectra for Linux

Linux builds and packaging for [Spectra](https://github.com/luinbytes/spectra).
This repository is a fork of [Helium for Linux](https://github.com/imputnet/helium-linux).

## Downloads

When published, Spectra builds for `x86_64/amd64` and `arm64/aarch64` appear
on [GitHub Releases](https://github.com/luinbytes/spectra-linux/releases)
as AppImages, binary tarballs, and `spectra-bin` Debian packages.

### Flatpak/Flathub
We will not support Flatpak as long as it's impossible to package Chromium
without [breaking its sandbox](https://discuss.privacyguides.net/t/does-flatpak-weaken-chromium-firefoxs-sandbox/13373/7).
Use the AppImage if your distribution has no Spectra package.

## Credits

[Depot](https://depot.dev/) sponsored the build runners for upstream Helium.

### Helium

Spectra's Linux build and packaging tooling comes from
[Helium for Linux](https://github.com/imputnet/helium-linux).

### ungoogled-chromium

Helium's Linux tooling originated in
[ungoogled-chromium-portablelinux](https://github.com/ungoogled-software/ungoogled-chromium-portablelinux).

## Contributing

See the [Spectra contribution guide](https://github.com/luinbytes/spectra/blob/main/CONTRIBUTING.md).

## License
All code, patches, modified portions of imported code or patches, and
any other content unique to Spectra or Helium is licensed under GPL-3.0. See [LICENSE](LICENSE).

Any content imported from other projects retains its original license (for
example, any original unmodified code imported from ungoogled-chromium remains
licensed under their [BSD 3-Clause license](LICENSE.ungoogled_chromium)).

## Building
To build the binary, run `scripts/docker-build.sh` from the repo root.

The `scripts/docker-build.sh` script will:
1. Create a Docker image of a Debian-based building environment with all
   required packages (llvm, nodejs and distro packages) included.
2. Run `scripts/build.sh` inside the Docker image to build Spectra.

Running `scripts/build.sh` directly will not work unless you're running a
Debian-based distro and have all necessary dependencies installed. This repo is
designed to avoid having to configure the building environment on your Linux
installation.

### Packaging
After building, run `scripts/package.sh`. Alternatively, you can run
`package/docker-package.sh` to build inside a Docker image. Either of these
scripts create `spectra-*_linux.tar.xz` and `spectra-*.AppImage` in
`build/release/`. Set `MAKE_DEB=1` to also build a `spectra-bin_*.deb`.
See the [packaging guide](package/README.md) for launcher and icon details.

### Development
By default, the build script uses tarball. If you need to use a source tree
clone, you can run `scripts/docker-build.sh -c` instead. This may be useful if
a tarball for a release isn't available yet.
