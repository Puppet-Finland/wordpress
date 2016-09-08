# == Class: wordpress::install
#
# This class installs wordpress
#
class wordpress::install
(
    $ensure

) inherits wordpress::params
{
    $package_require = $::osfamily ? {
        'RedHat' => Class['epel'],
        default  => undef,
    }

    # Install Wordpress
    package { $::wordpress::params::package_name:
        ensure  => $ensure,
        require => $package_require,
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
