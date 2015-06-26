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

    # Fetch Wordpress secret keys
    $keys = "${::wordpress::params::config_dir}/wp-keys.php"

    exec { 'wordpress fetch secret keys':
        command => "echo '<?php' > ${keys} && curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> ${keys}",
        path    => ['/usr/bin'],
        unless  => "test -f ${keys}",
        user    => $::os::params::adminuser,
        require => Class['wordpress::install'],
    }

    file { 'wordpress-wp-keys.php':
        path    => "${::wordpress::params::config_dir}/wp-keys.php",
        owner   => $::os::params::adminuser,
        group   => $::apache2::params::www_group,
        mode    => '0640',
        require => Exec['wordpress fetch secret keys'],
    }

}
