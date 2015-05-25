# == Class: wordpress::config::common
#
# This class configures common aspects of all Wordpress installations
#
class wordpress::config::common
(
    $ensure,
    $dbname,
    $dbuser,
    $dbpassword

) inherits wordpress::params
{
    concat { 'wordpress-wp-config.php':
        ensure  => $ensure,
        path    => $::wordpress::params::config_name,
        owner   => $::os::params::adminuser,
        group   => $::apache2::params::www_group,
        mode    => '0640',
        require => Class['wordpress::install'],
    }

    Concat::Fragment {
        target => 'wordpress-wp-config.php'
    }

    concat::fragment { 'wordpress-head':
        content => "<?php\n",
    }
    concat::fragment { 'wordpress-wp-base.php':
        content => template('wordpress/wp-base.php.erb'),
    }

    # This template file contains dynamic content, so we need to upload it
    # first, then use the uploaded file as a source for the concat::fragment
    # define. The replace => true ensures that even if the template's contents
    # changes (as they do on every run), the concat::fragment remains the same.
    #
    # This neat trick was adapted from
    #
    # <https://github.com/hunner/puppet-wordpress>
    #
    file { 'wordpress-wp-keys.php':
        name    => "${::wordpress::params::config_dir}/wp-keys.php",
        content => template('wordpress/wp-keys.php.erb'),
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0640',
        replace => false,
        require => Class['wordpress::install'],
    }
    concat::fragment { 'wordpress-wp-keys.php':
        source  => "${::wordpress::params::config_dir}/wp-keys.php",
        require => File['wordpress-wp-keys.php'],
    }
}
