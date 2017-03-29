#!/bin/sh
# Detects which OS and if it is Linux then it will detect which Linux
# Distribution.
# http://linuxmafia.com/faq/Admin/release-files.html




GetVersionFromFile()
{
	VERSION="$(tr "\n" ' ' < cat "$1" | sed s/.*VERSION.*=\ // )"
}

# shellcheck disable=SC2039
if [ -z "${OSTYPE+x}" ]; then
	case $OSTYPE in
		solaris*) 
			OS="Solaris"
			;;
	  	darwin*)  
			OS="macos"
			;; 
	  	linux*)   
			OS="Linux"
			;;
	  	bsd*)     
			OS="bsd" 
			;;
	  	msys*)    
			OS="msys" 
			;;
		cygwin*)    
			OS="cygwin" 
			;;
	  	*)    
	  		OS=$(uname -s)
			echo "unknown: $OSTYPE"
			echo "using OS value $OS"
			;;
	esac
else
	OS=$(uname -s)
	echo "No OSTYPE"
	echo "using OS value $OS"
fi

REV=$(uname -r)
MACH=$(uname -m)


if [ "${OS}" = "SunOS" ] ; then
	OS=Solaris
	ARCH=$(uname -p)
	OSSTR="${OS} ${REV}(${ARCH} $(uname -v)"
elif [ "${OS}" = "AIX" ] ; then
	OSSTR="${OS} $(oslevel) ($(oslevel -r)"
elif [ "${OS}" = "Linux" ] ; then
	KERNEL=$(uname -r)
	if [ -f /etc/redhat-release ] ; then
		DIST='RedHat'
		PSUEDONAME=$(sed s/.*\(// < /etc/redhat-release | sed s/\)//)
		REV=$(sed s/.*release\ // < /etc/redhat-release | sed s/\ .*//)
	elif [ -f /etc/SuSE-release ] ; then
		DIST=$(tr "\n" ' ' < /etc/SuSE-release | sed s/VERSION.*//)
		REV=$(tr "\n" ' ' < /etc/SuSE-release| sed s/.*=\ //)
	elif [ -f /etc/mandrake-release ] ; then
		DIST='Mandrake'
		PSUEDONAME=$(sed s/.*\(// < /etc/mandrake-release | sed s/\)//)
		REV=$(sed s/.*release\ // < /etc/mandrake-release | sed s/\ .*//)
	elif [ -f /etc/debian_version ] ; then	
		if [ "$(awk -F= '/DISTRIB_ID/ {print $2}' /etc/lsb-release)" = "Ubuntu" ]; then
			DIST="Ubuntu"
		else
			DIST="Debian $(cat /etc/debian_version)"
			REV=""
		fi
	elif [ -f /etc/arch-release ] ; then
		DIST="Arch"
	fi
	if [ -f /etc/UnitedLinux-release ] ; then
		DIST="${DIST}[$(tr "\n" ' ' < /etc/UnitedLinux-release | sed s/VERSION.*//)]"
	fi

	OSSTR="${OS} ${DIST} ${REV}(${PSUEDONAME} ${KERNEL} ${MACH})"
fi

get_distro() {
	echo "${DIST}"
}

get_os() {
	echo "${OS}"
}

get_version(){
	echo "${VERSION}"
}

get_osstr(){
	echo "${OSSTR}"
}