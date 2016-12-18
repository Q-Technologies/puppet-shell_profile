class shell_profile {

    case $osfamily {
        'Suse': {
            $local_bashrc = '/etc/bash.bashrc.local'
        }
        'RedHat', 'Centos': {
            $local_bashrc = '/etc/profile.d/local.sh'
        }
        'Darwin': {
            $local_bashrc = '/etc/bash.bashrc.local'
        }
        'Debian': {
            $local_bashrc = '/etc/profile.d/local.sh'
        }
        default: {
            fail("This module is note designed for ${::osfamily}")
        }
    }

    if $osfamily == 'Darwin' {
        file {'/etc/bashrc':
            ensure  => file,
            mode    => '0444',
            source  => "puppet:///modules/shell_profile/bashrc.mac",
        }
    }

    if $osfamily == 'Debian' {
        file {'/etc/bash.bashrc':
            ensure  => file,
            mode    => '0444',
            source  => "puppet:///modules/shell_profile/bashrc.debian",
        }
    }

    file { $local_bashrc:
          ensure  => file,
          mode    => '0644',
          source  => "puppet:///modules/shell_profile/bash.bashrc.local",
    }
  
}
