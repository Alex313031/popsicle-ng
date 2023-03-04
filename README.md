# Popsicle-ng <img src="https://raw.githubusercontent.com/Alex313031/popsicle-ng/master/Logo.png" width="64">

Popsicle-ng is a Linux utility for flashing multiple USB devices in parallel, written in [Rust](https://www.rust-lang.org/en-US/).] \
It is a fork of [Popsicle](https://github.com/pop-os/popsicle), which is made by [system76](https://system76.com/) and included in [PopOS!](https://pop.system76.com/).

## Build Dependencies

You can use `./build.sh --deps` to install build deps on Debian/Ubuntu.

If building the GTK front end, you will be required to install the development dependencies for GTK and D-Bus, usually named `libgtk-3-dev` and `libdbus-1-dev`, respectively. You will also need libclang, usually `libclang1`, and Rust's Cargo utility, usually named `cargo`.

For those who need to vendor Cargo's crate dependencies which are fetched from [Crates.io](https://crates.io/), you will need to install [cargo-vendor](https://github.com/alexcrichton/cargo-vendor), and then run `make vendor`.

## Installation Instructions

### With build script
I have made a build script, called "build.sh" for automatically handling building, installing, debugging, etc. of Popsicle.ng.
Please run `./build.sh --help` to see available options.
For quick building/installing, one can use:
`./build.sh --deps && ./build.sh --build && ./build.sh --install`

### Manual

 A makefile is included for simply building and installing all required files into the system. You may either build both the CLI and GTK workspace, just the CLI workspace, or just the GTK workspace.

- `make cli && sudo make install-cli` will build and install just the CLI workspace
- `make gtk && sudo make install-gtk` will build and install just the GTK workspace
- `make && sudo make install` will build and install both the CLI and GTK workspaces
Note: Run `export DEBUG=1` to make a debug build.

## Screenshots

### Image Selection

![Image Selection](./screenshots/screenshot-01.png)

### Device Selection

![Device Selection](./screenshots/screenshot-02.png)

The list will also dynamically refresh as devices are added and removed

![GIF Demo](./screenshots/device-monitoring.gif)

### Device Flashing

![Flashing Devices](./screenshots/screenshot-03.png)
![Flashing Devices](./screenshots/screenshot-04.png)

### Summary

![Summary](./screenshots/screenshot-05.png)

## Translators

Translators are welcome to submit translations directly as a pull request to this project. It is generally expected that your pull requests will contain a single commit for each language that was added or improved, using a syntax like so:

```
i18n(eo): Add Esperanto language support
```

```
i18n(pl): Improvements to Polish language support
```

Translation files can be found [here](./i18n/). We are using [Project Fluent](https://projectfluent.org) for our translations, which should be easier than working with gettext.

### Supported Languages

- [English](./i18n/en/)
- [Bangla](./i18n/bn/)
- [German](./i18n/de/)
- [Italian](./i18n/it/)
- [Spanish](./i18n/es/)
- [French](./i18n/fr/)
- [Hungarian](./i18n/hu/)
- [Dutch](./i18n/nl/)
- [Polish](./i18n/pl/)
- [Brazilian Portuguese](./i18n/pt-BR/)
- [Portuguese](./i18n/pt/)
- [Russian](./i18n/ru/)
- [Serbian](./i18n/sr/)
- [Swedish](./i18n/sv/)
- [Turkish](./i18n/tr/)
- [Catalan](./i18n/ca)
- [Chinese (Simplified)](./i18n/zh-CN)
- [Czech](./i18n/cs)
- [Japanese](./i18n/ja)
- [Korean](./i18n/ko)
- [Slovenian](./i18n/sl)
