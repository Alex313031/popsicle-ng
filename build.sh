#!/bin/bash

# Copyright (c) 2023 Alex313031.

YEL='\033[1;33m' # Yellow
CYA='\033[1;96m' # Cyan
RED='\033[1;31m' # Red
GRE='\033[1;32m' # Green
c0='\033[0m' # Reset Text
bold='\033[1m' # Bold Text
underline='\033[4m' # Underline Text

# Error handling
yell() { echo "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "${RED}Failed $*"; }

# --help
displayHelp () {
	printf "\n" &&
	printf "${bold}${GRE}Script to build Popsicle-ng on Linux.${c0}\n" &&
	printf "${YEL}Use the --deps flags to install build dependencies.\n" &&
	printf "${YEL}Use the --clean flag to run \`make clean\` & \`make distclean\`\n" &&
	printf "${YEL}Use the --cli flag to only build the CLI binary.\n" &&
	printf "${YEL}Use the --gtk flag to only build the GUI binary.\n" &&
	printf "${YEL}Use the --build flag to only build both the CLI and GUI (normal build).\n" &&
	printf "${YEL}Use the --debug flag to make a debugging build.\n" &&
	printf "${YEL}Use the --install flag to run \`make install\`.\n" &&
	printf "${YEL}Use the --install-cli flag to run \`make install-cli\`.\n" &&
	printf "${YEL}Use the --install-gtk flag to run \`make install-gtk\`.\n" &&
	printf "${YEL}Use the --uninstall flag to run \`make uninstall\`.\n" &&
	printf "${c0}\n"
}

case $1 in
	--help) displayHelp; exit 0;;
esac

# Install build dependencies
installDeps () {
	sudo apt install cargo help2man libclang1 libclang-dev libdbus-1-dev libgtk-3-dev libudev-dev patchelf
}

case $1 in
	--deps) installDeps; exit 0;;
esac

# Clean artifacts
makeClean () {
	printf "\n" &&
	printf "${YEL}Uninstalling Popsicle-ng, and running \`make clean\` & \`make distclean\`...\n" &&
	printf "${c0}\n" &&
	make uninstall VERBOSE=1 V=1 && make clean && make distclean
}

case $1 in
	--clean) makeClean; exit 0;;
esac

# Build Popsicle-ng
buildPopsicle () {
printf "\n" &&
printf "${YEL}Building popsicle-ng-cli and popsicle-ng-gtk...\n" &&
printf "${c0}\n" &&

export NINJA_SUMMARIZE_BUILD=1 &&
export VERBOSE=1 &&
export V=1 &&
export DEBUG=0 &&
export CFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CXXFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CPPFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export LDFLAGS="-Wl,-O3 -mavx -maes" &&
export RUSTFLAGS="-Copt-level=3 -Ctarget-feature=+avx,+aes -Clink-arg=-Wl,-O3 -Cstrip=symbols" &&
export RUSTC_LOG="rustc_codegen_ssa::back::link=info"

make VERBOSE=1 V=1 &&

printf "\n" &&
printf "${GRE}${bold}Build Completed. ${YEL}${bold}You can now run \`./build.sh --install\` to install it.\n" &&
printf "${c0}\n"
}
case $1 in
	--build) buildPopsicle; exit 0;;
esac

# Build Popsicle-ng cli
buildPopsicleCLI () {
printf "\n" &&
printf "${YEL}Building popsicle-ng-cli (Command Line Version)...\n" &&
printf "${c0}\n" &&

export NINJA_SUMMARIZE_BUILD=1 &&
export VERBOSE=1 &&
export V=1 &&
export DEBUG=0 &&
export CFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CXXFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CPPFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export LDFLAGS="-Wl,-O3 -mavx -maes" &&
export RUSTFLAGS="-Copt-level=3 -Ctarget-feature=+avx,+aes -Clink-arg=-Wl,-O3 -Cstrip=symbols" &&
export RUSTC_LOG="rustc_codegen_ssa::back::link=info"

make cli VERBOSE=1 V=1 &&

printf "\n" &&
printf "${GRE}${bold}Build Completed. ${YEL}${bold}You can now run \`./build.sh --install\` to install it.\n" &&
printf "${c0}\n"
}
case $1 in
	--cli) buildPopsicleCLI; exit 0;;
esac

# Build Popsicle-ng gui
buildPopsicleGTK () {
printf "\n" &&
printf "${YEL}Building popsicle-ng-gtk (GUI Version)...\n" &&
printf "${c0}\n" &&

export NINJA_SUMMARIZE_BUILD=1 &&
export VERBOSE=1 &&
export V=1 &&
export DEBUG=0 &&
export CFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CXXFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CPPFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export LDFLAGS="-Wl,-O3 -mavx -maes" &&
export RUSTFLAGS="-Copt-level=3 -Ctarget-feature=+avx,+aes -Clink-arg=-Wl,-O3 -Cstrip=symbols" &&
export RUSTC_LOG="rustc_codegen_ssa::back::link=info"

make gtk VERBOSE=1 V=1 &&

printf "\n" &&
printf "${GRE}${bold}Build Completed. ${YEL}${bold}You can now run \`./build.sh --install\` to install it.\n" &&
printf "${c0}\n"
}
case $1 in
	--gtk) buildPopsicleGTK; exit 0;;
esac

# Build debug Popsicle-ng
buildPopsicleDebug () {
printf "\n" &&
printf "${YEL}Building popsicle-ng-cli and popsicle-ng-gtk (DEBUG Version)...\n" &&
printf "${c0}\n" &&

export NINJA_SUMMARIZE_BUILD=1 &&
export VERBOSE=1 &&
export V=1 &&
export DEBUG=1 &&
export CFLAGS="-Wall -DDEBUG -g3 -O0" &&
export CXXFLAGS="-Wall -DDEBUG -g3 -O0" &&
export CPPFLAGS="-Wall -DDEBUG -g3 -O0" &&
export LDFLAGS="-Wall -Wl,-O0 -g3" &&
export RUSTFLAGS="-Copt-level=0" &&
export RUSTC_LOG="rustc_codegen_ssa::back::link=info"

make VERBOSE=1 V=1 &&

printf "\n" &&
printf "${GRE}${bold}Debug Build Completed. ${YEL}${bold}You can now run \`./build.sh --install\` to install it.\n" &&
printf "${c0}\n"
}
case $1 in
	--debug) buildPopsicleDebug; exit 0;;
esac

# Install Popsicle
installPopsicle () {
printf "\n" &&
printf "${YEL}Installing Popsicle-ng...\n" &&
printf "${c0}\n" &&

mkdir -p out &&

export NINJA_SUMMARIZE_BUILD=1 &&
export VERBOSE=1 &&
export V=1 &&
export DEBUG=0 &&
export CFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CXXFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CPPFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export LDFLAGS="-Wl,-O3 -mavx -maes" &&
export RUSTFLAGS="-Copt-level=3 -Ctarget-feature=+avx,+aes -Clink-arg=-Wl,-O3 -Cstrip=symbols" &&
export RUSTC_LOG="rustc_codegen_ssa::back::link=info"

make install VERBOSE=1 V=1 &&

printf "\n" &&
printf "${GRE}${bold}Done!\n" &&
printf "${c0}\n"
}
case $1 in
	--install) installPopsicle; exit 0;;
esac

# Install Popsicle CLI
installPopsicleCLI () {
printf "\n" &&
printf "${YEL}Installing Popsicle-ng CLI...\n" &&
printf "${c0}\n" &&

mkdir -p out &&

export NINJA_SUMMARIZE_BUILD=1 &&
export VERBOSE=1 &&
export V=1 &&
export DEBUG=0 &&
export CFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CXXFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CPPFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export LDFLAGS="-Wl,-O3 -mavx -maes" &&
export RUSTFLAGS="-Copt-level=3 -Ctarget-feature=+avx,+aes -Clink-arg=-Wl,-O3 -Cstrip=symbols" &&
export RUSTC_LOG="rustc_codegen_ssa::back::link=info"

make install-cli VERBOSE=1 V=1 &&

printf "\n" &&
printf "${GRE}${bold}Done!\n" &&
printf "${c0}\n"
}
case $1 in
	--install-cli) installPopsicleCLI; exit 0;;
esac

# Install Popsicle GUI
installPopsicleGTK () {
printf "\n" &&
printf "${YEL}Installing Popsicle-ng GUI...\n" &&
printf "${c0}\n" &&

mkdir -p out &&

export NINJA_SUMMARIZE_BUILD=1 &&
export VERBOSE=1 &&
export V=1 &&
export DEBUG=0 &&
export CFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CXXFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CPPFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export LDFLAGS="-Wl,-O3 -mavx -maes" &&
export RUSTFLAGS="-Copt-level=3 -Ctarget-feature=+avx,+aes -Clink-arg=-Wl,-O3 -Cstrip=symbols" &&
export RUSTC_LOG="rustc_codegen_ssa::back::link=info"

make install-gtk VERBOSE=1 V=1 &&

printf "\n" &&
printf "${GRE}${bold}Done!\n" &&
printf "${c0}\n"
}
case $1 in
	--install-gtk) installPopsicleGTK; exit 0;;
esac

# Uninstall Popsicle
uninstallPopsicle () {
printf "\n" &&
printf "${YEL}Uninstalling Popsicle-ng...\n" &&
printf "${c0}\n" &&

export NINJA_SUMMARIZE_BUILD=1 &&
export VERBOSE=1 &&
export V=1 &&
export DEBUG=0 &&
export CFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CXXFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export CPPFLAGS="-DNDEBUG -g0 -s -O3 -mavx -maes" &&
export LDFLAGS="-Wl,-O3 -mavx -maes" &&
export RUSTFLAGS="-Copt-level=3 -Ctarget-feature=+avx,+aes -Clink-arg=-Wl,-O3 -Cstrip=symbols" &&
export RUSTC_LOG="rustc_codegen_ssa::back::link=info"

make uninstall VERBOSE=1 V=1 &&

rm -r -f ./out/* &&

printf "\n" &&
printf "${GRE}${bold}Done.\n" &&
printf "${c0}\n"
}
case $1 in
	--uninstall) uninstallPopsicle; exit 0;;
esac

printf "\n" &&
printf "${bold}${GRE}Script to build Popsicle-ng on Linux.${c0}\n" &&
printf "${YEL}Use the --deps flags to install build dependencies.\n" &&
printf "${YEL}Use the --clean flag to run \`make clean\` & \`make distclean\`\n" &&
printf "${YEL}Use the --cli flag to only build the CLI binary.\n" &&
printf "${YEL}Use the --gtk flag to only build the GUI binary.\n" &&
printf "${YEL}Use the --build flag to only build both the CLI and GUI (normal build).\n" &&
printf "${YEL}Use the --debug flag to make a debugging build.\n" &&
printf "${YEL}Use the --install flag to run \`make install\`.\n" &&
printf "${YEL}Use the --install-cli flag to run \`make install-cli\`.\n" &&
printf "${YEL}Use the --install-gtk flag to run \`make install-gtk\`.\n" &&
printf "${YEL}Use the --uninstall flag to run \`make uninstall\`.\n" &&
printf "${c0}\n" &&

tput sgr0 &&
exit 0
