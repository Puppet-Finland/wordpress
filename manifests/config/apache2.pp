#
# == Class: wordpress::config::apache2
#
# Configure Apache2 for Wordpress
#
class wordpress::config::apache2
(
    $ensure,
    $authz_require

) inherits wordpress::params
{
    file { 'wordpress-wordpress.conf':
        ensure  => $ensure,
        name    => $::wordpress::params::apache2_config_name,
        content => template('wordpress/wordpress.conf.erb'),
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0644',
        require => Class['apache2::install'],
    }
}
