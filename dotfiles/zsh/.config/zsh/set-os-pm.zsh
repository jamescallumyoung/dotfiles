#
# Sets the OS_PM variable, which is used throughout the configs to determine what OS and package manager(s) are in use
#
# Arguments:
# if $macos_use_homebrew == 1 homebrew will be enabled on macOS
# if $linux_use_homebrew == 1 homebrew will be enabled on linux
#
# OS_PM is formatted as follows:
# {uname -s}__{detected package managers}
#
# Valid values for linuxes are:
#   Linux__apt              -- apt
#   Linux__apt,homebrew     -- apt AND homebrew
#   Linux__unknown          -- the native package manager is unknown
#   Linux__unknown,homebrew -- the native package manager is unknown but homebrew is enabled
# for macOS:
#   Darwin__homebrew        -- homebrew
#   Darwin__none            -- no package managers enabled
#
set_os_pm () {
  os=$(uname -s)

  case $os in
  "Darwin")
      if [[ $macos_use_homebrew == 1 ]]; then
          OS_PM="${os}__homebrew"
      else
          OS_PM="${os}__no_homebrew"
      fi
      ;;
  "Linux")
      if command -v apt > /dev/null; then # `apt` - debian linux
          OS_PM="${os}__apt"
      else
          echo "Unknown package manager! System configs could not be set. System may not behave as expected."
          OS_PM="${os}__unknown"          # unknown package manager
      fi

      # add homebrew clause if homebrew _should be_ set up
      # note that homebrew is enabled _after_ OS_PM is set, unlike other package managers
      if [[ $linux_use_homebrew == 1 ]]; then
          OS_PM="${OS_PM},homebrew"
      fi
      ;;
  *)
      OS_PM="unknown__unknown"
      echo "Unknown OS! OS_PM=${OS_PM}"
      ;;
  esac

  unset $os
  export $OS_PM
}
