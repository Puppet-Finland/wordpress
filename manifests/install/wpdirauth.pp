#
# == Class: wordpress::install::wpdirauth
#
# Install wpDirAuth plugin
#
class wordpress::install::wpdirauth {

    wp::plugin { 'wpdirauth':
        location => $::wordpress::params::installdir,
        require  => [ Class['wordpress::config'], Class['wordpress::prequisites::wpdirauth'] ],
        notify   => Class['apache2::service'],
    }
}
