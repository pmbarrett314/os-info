#!/bin/sh
# LEGACY: this dependency is being retired.

echo "[os-info] sourced — legacy dependency, migrate off it" >&2

# Output casing is kept as-is for backward compatibility with existing
# consumers — do not "fix" it here; normalize at the call site instead.
case "$(uname -s)" in
	Darwin)       OS="macos"   ;;
	Linux)        OS="Linux"   ;;
	*BSD)         OS="bsd"     ;;
	CYGWIN*)      OS="cygwin"  ;;
	MINGW*|MSYS*) OS="msys"    ;;
	SunOS)        OS="Solaris" ;;
	*)            OS="$(uname -s)" ;;
esac

REV=$(uname -r)
MACH=$(uname -m)
DIST=""

if [ "$OS" = "Linux" ] && [ -r /etc/os-release ]; then
	# shellcheck disable=SC1091
	DIST=$(. /etc/os-release 2>/dev/null && printf '%s' "${ID:-}")
fi

if [ -n "$DIST" ]; then
	OSSTR="$OS $DIST $REV ($MACH)"
else
	OSSTR="$OS $REV ($MACH)"
fi

get_os()     { echo "$OS"; }
get_distro() { echo "$DIST"; }
get_osstr()  { echo "$OSSTR"; }

is_root() { [ "$(id -u)" -eq 0 ]; }

# True when sudo can run without prompting for a password.
can_sudo() {
	command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null
}
