# == Class: wordpress::config
#
# This class configures Wordpress
#
class wordpress::config
(
    $ensure,
    $authz_require,
    $dbname,
    $dbuser,
    $dbpassword,
    $wpurl,
    $wptitle,
    $wpadmin,
    $wpadmin_password,
    $wpadmin_email,
    $plugins,
    $options,
    $themes

) inherits wordpress::params
{
    class { '::wordpress::config::apache2':
        ensure        => $ensure,
        authz_require => $authz_require,
    }

    class { '::wordpress::config::mysql':
        ensure     => $ensure,
        dbname     => $dbname,
        dbuser     => $dbuser,
        dbpassword => $dbpassword,
    }

    class { '::wordpress::config::common':
        ensure     => $ensure,
        dbname     => $dbname,
        dbuser     => $dbuser,
        dbpassword => $dbpassword,
    }

    wp::site { "wordpress-site-${wptitle}":
        location       => $::wordpress::params::installdir,
        url            => $wpurl,
        sitename       => $wptitle,
        admin_user     => $wpadmin,
        admin_password => $wpadmin_password,
        admin_email    => $wpadmin_email,
        require        => Class['wordpress::config::mysql'],
    }

    # Install plugins and themes and configure options
    create_resources('wp::plugin', $plugins)
    create_resources('wp::option', $options)
    create_resources('wp::themes', $themes)
}
