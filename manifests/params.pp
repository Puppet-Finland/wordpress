#
# == Class: wordpress::params
#
# Defines some variables based on the operating system
#
class wordpress::params {

    include ::os::params
    include ::apache2::params

    case $::osfamily {
        'RedHat': {
            $package_name = 'wordpress'
            $config_dir = '/etc/wordpress'
            $config_name = "${config_dir}/wp-config.php"
            $installdir = '/usr/share/wordpress'
            $apache2_config_name = "${::apache2::params::conf_d_dir}/wordpress.conf"
        }
        'Debian': {
            $package_name = 'wordpress'
            $config_dir = '/etc/wordpress'
            $config_name = "${config_dir}/wp-config.php"
            $installdir = '/usr/share/wordpress'
        }
        default: {
            fail("Unsupported OS: ${::osfamily}")
        }
    }
}
