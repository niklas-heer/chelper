set -e

install_config()
{
	# Check if it already exists -> abort
	# If not:
	# - Download file
	# - make folder
	# - move to folder
	# - dialog to choose (check whiptail/maybe let it work with dialog)

	install_path="/etc/chelper"
	chelper_config="config.yml"

	# only install the config file if none exists
	if [ ! -f "${install_path}/${chelper_config}" ]; then
	    echo "File not found!"
	fi

	# whiptail --checklist "Please pick one" 10 60 5 one one off two two off\
    # three three off four four off  five five off
}

install_chelper()
{
	install_path="/usr/local/bin"
	chelper_bin="chelper"

	# Back up existing chelper, if any
	chelper_cur_ver="$(chelper --version 2>/dev/null | cut -d ' ' -f2)"
	if [ -n "${chelper_cur_ver}" ]; then
		# chelper of some version is already installed
		chelper_path="$(which chelper)"
		chelper_backup="${chelper_path}_${chelper_cur_ver}"
		echo "Backing up ${chelper_path} to ${chelper_backup}"
		echo "(Password may be required.)"
		sudo mv "${chelper_path}" "${chelper_backup}"
	fi

	########################
	# Download and extract #
	########################
	echo "Downloading chlper..."
	chelper_file="chlper"
	chelper_url="https://raw.githubusercontent.com/niklas-heer/chelper/master/chelper"
	echo "$chelper_url"

	# Use $PREFIX for compatibility with Termux on Android
	rm -rf "/tmp/${chelper_file}"

	if [ -n "$(which curl)" ]; then
		curl -fsSL "$chelper_url" \
			-o "/tmp/${chelper_file}"
	elif [ -n "$(which wget)" ]; then
		wget --quiet "$chelper_url" \
			-O "/tmp/${chelper_file}"
	else
		echo "could not find curl or wget"
		exit 4
	fi

	chmod +x "/tmp/${chelper_bin}"

	echo "Putting caddy in ${install_path} (may require password)"
	sudo mv "/tmp/${chelper_bin}" "${install_path}/${chelper_bin}"
	sudo rm "/tmp/${chelper_file}"

	# check installation
	$chelper_bin --version

	echo "Successfully installed"
	exit 0
}

# install_chelper "$@"
install_config "$@"
