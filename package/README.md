# Spectra packaging guidelines

This document provides guidelines for packagers creating Spectra packages
for various Linux distributions and packaging systems. These guidelines
aim to ensure consistency across different package formats while
respecting distribution-specific conventions.

## Installation
- The installation prefix of Spectra packages is not mandated by
  upstream. Note that on FHS-compliant distributions, Chromium-based
  browsers are typically installed into /opt or /usr/lib64.
- The primary executable should be a symbolic link to
  $prefix/spectra-wrapper. On FHS-compliant distributions, it should
  be installed into `/usr/bin` or `/usr/local/bin`.

## Branding
- The primary executable name should be `spectra`.
- The package name should be `spectra` if available; `spectra-browser`
  is acceptable otherwise. If the packaging system uses reverse-DNS
  notation as identifiers, the identifier should be `io.github.luinbytes.spectra`
  (all lowercase).
- If built from releases marked as "pre-release", the package name
  should have a `-prerelease` (preferred), `-pre` or `-beta` suffix.
- If built from GitHub-hosted binaries, the package name should have a
  `-bin` suffix.
- If installing the desktop file, it should be named `spectra.desktop`
   (or `io.github.luinbytes.spectra.desktop` on systems preferring reverse-DNS
    naming).
- If installing icons, the icon name should be `spectra`
  (or `io.github.luinbytes.spectra`).

Official packages install under `/opt/spectra`. The public `spectra`
command links to `spectra-wrapper`. The browser still uses the inherited
`net.imput.helium` profile directory to preserve existing profiles.

The shipped `spectra.png` is the 256 px rendering of the
[approved Found line SVG](https://github.com/luinbytes/spectra/blob/bca63fac4fc43611f9e782c66ee84914a5ee2fd0/docs/logo-directions/b-found-line-redraw.svg).
Regenerate it from that source with `resvg --width 256 b-found-line-redraw.svg package/spectra.png`.
The tarball carries it as `product_logo_256.png`. The AppImage and
Debian/RPM installers use it as `spectra.png`.

## Versioning
- Package versions should match the upstream version number.
- Package versions may include a package revision suffix (e.g. `-1` in
  `0.8.7.1-1`) for the convenience of package development and
  maintenance.

## Tweaks
- Packages should not add environment-specific flags by default,
  such as enabling or disabling features via `--enable-features`
  or `--disable-features`.
- Packages should replace the `CHROME_VERSION_EXTRA` envvar with their
  distribution name (e.g. `Arch Linux`) or method of distribution
  (e.g. `rpm`) to assist with easier bug report handling.

## Security
- Packages MUST NOT add default arguments that weaken the security of
  Spectra, including but not limited to `--no-sandbox`.
- Packages MUST NOT be built with disabled build-time security features
  (e.g. `is_cfi=false`).

## Bonus points/nice-to-haves
- If built from source, the release is built with PGO (`chrome_pgo_phase=2`).
- If built from source, symbols are stripped (and maybe shipped separately).
- Packagers are encouraged to provide MAC security profiles where
  applicable for enhanced security.
