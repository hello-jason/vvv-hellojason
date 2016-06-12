# Post Provision
#
# provision-post.sh acts as a post-hook to the default provisioning. Anything that should
# run after the shell commands laid out in provision.sh or provision-custom.sh should be
# put into this file. This provides a good opportunity to install additional packages
# without having to replace the entire default provisioning script.

extra_apt_packages_install() {
  local extra_apt_package_install_list=()

  # List of packages to be installed
  local extra_apt_packages_list=(
    htop
  )

  # # Loop through each of our packages that should be installed on the system. If
  # not yet installed, it should be added to the array of packages to install.
  local pkg
  for pkg in "${extra_apt_packages_list[@]}"; do
    if not_installed "${pkg}"; then
      echo " *" $pkg [not installed]
      apt-get install -y "#{pkg}"
    fi
  done
}

extra_npm_install() {
  local extra_npm_install_list=()

  # List of packages to be installed
  local extra_npm_list=(
    http-server
    ngrok
    bower
    gulp
  )

  # Loop through each of our packages that should be installed on the system. If
  # not yet installed, it should be added to the array of packages to install.
  local pkg
  for pkg in "${extra_npm_list[@]}"; do
    if [[ "$(${pkg} --version)" ]]; then
      echo "Updating http-server"
      npm update -g http-server &>/dev/null
    else
      echo "Installing http-server"
      npm install -g http-server &>/dev/null
    fi
  done
}

zshell_install() {
  # Install zss
  if not_installed "zsh"; then
  fi
  # Install zshell
  echo "Installing zshell"
  apt-get -y install zsh
  # Install oh-my-zsh
  echo "Installing oh-my-zsh"
  wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

  # Change shell to zsh
  if [[ echo $0 != `which zsh` ]]; then echo "not zsh" fi
    chsh -s `which zsh`
  fi
}

install_vvv_dashboard() {
  # VVV_Dashboard
  # Documentation: https://github.com/topdown/VVV-Dashboard
  git clone https://github.com/topdown/VVV-Dashboard.git /srv/www/default/dashboard
  cp /srv/www/default/dashboard/dashboard-custom.php /srv/www/default/
}

# Run scripts
zshell_install
extra_apt_packages_install
extra_npm_install
install_vvv_dashboard
