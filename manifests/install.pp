# == Class: wordpress::install
#
# This class installs wordpress
#
class wordpress::install
(
    $ensure

) inherits wordpress::params
{
    # Install Wordpress
    package { $::wordpress::params::package_name:
        ensure => $ensure,
    }

    # Install wp-cli using rmccue/wp module
    class { '::wp':
        location => $::wordpress::params::installdir,
        user     => $::apache2::params::www_user,
    }
    class { '::wp::cli':
        ensure       => $ensure,
        install_path => '/opt/wp-cli',
    }
}
