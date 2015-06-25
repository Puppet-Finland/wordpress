#
# == Class: wordpress
#
# Install and configure Wordpress
#
# == Parameters
#
# [*manage*]
#   Whether to manage Wordpress using Puppet. Valid values are 'yes' (default) 
#   and 'no'.
# [*manage_config*]
#   Whether to manage the configuration of Wordpress using Puppet. Valid values 
#   are 'yes' (default) and 'no'.
# [*ensure*]
#   Status of Wordpress. Valid values are 'present' (default) and 'absent'.
# [*authz_require*]
#   The value of "Require" parameter for mod_authz_core in Apache. For example 
#   'local' or 'all granted'. Defaults to 'all granted' which allows access to 
#   Wordpress from any location.
# [*dbname*]
#   Wordpress database name. Defaults to 'wordpress'.
# [*dbuser*]
#   Wordpress database user. Defaults to 'wpuser'.
# [*dbpassword*]
#   Password for the Wordpress database user. No default value.
# [*wpurl*]
#   URL of the Wordpress site. For example 
#   'http://wordpress.domain.com/wordpress'. No default value.
# [*wptitle*]
#   Title (name) of the Wordpress site. No default value.
# [*wpadmin*]
#   Wordpress administrator username. Defaults to 'admin'.
# [*wpadmin_password*]
#   Wordpress administrator password. No default value.
# [*wpadmin_email*]
#   Wordpress administrator email address. No default value.
# [*theme*]
#   Wordpress theme to use. Defaults to 'twentyfourteen'.
# [*plugins*]
#   A hash of wp::plugin resources to realize.
# [*options*]
#   A hash of wp::option resources to realize.
# [*themes*]
#   A hash of wp::theme resources to realize.
#
# == Examples
#
# An example using Hiera:
#
#   ---
#   classes:
#    - wordpress
#    - webserver
#    - apache2
#    - mysql
#
#   wordpress::dbpassword: 'secret-password'
#   wordpress::wpadmin: 'admin'
#   wordpress::wpadmin_password: 'another-secret-password'
#   wordpress::wpadmin_email: 'admin@domain.com'
#   wordpress::wpurl: 'http://wordpress.domain.com/wordpress'
#   wordpress::wptitle: 'Acme Oy Intranet'
#
# == Authors
#
# Samuli Seppänen <samuli.seppanen@gmail.com>
#
# Samuli Seppänen <samuli@openvpn.net>
#
# == License
#
# BSD-license. See file LICENSE for details.
#
class wordpress
(
    $dbpassword,
    $wpurl,
    $wptitle,
    $wpadmin_password,
    $wpadmin_email,
    $ensure = 'present',
    $authz_require = 'all granted',
    $manage = 'yes',
    $manage_config = 'yes',
    $dbname = 'wordpress',
    $dbuser = 'wpuser',
    $wpadmin = 'admin',
    $theme = 'twentyfourteen',
    $plugins = {},
    $options = {},
    $themes = {}
)
{

if $manage == 'yes' {

    class { '::wordpress::install':
        ensure => $ensure,
    }

    if $manage_config == 'yes' {
        class { '::wordpress::config':
            ensure           => $ensure,
            authz_require    => $authz_require,
            dbname           => $dbname,
            dbuser           => $dbuser,
            dbpassword       => $dbpassword,
            wpurl            => $wpurl,
            wptitle          => $wptitle,
            wpadmin          => $wpadmin,
            wpadmin_password => $wpadmin_password,
            wpadmin_email    => $wpadmin_email,
            theme            => $theme,
            plugins          => $plugins,
            options          => $options,
            themes           => $themes,
        }
    }
}
}
