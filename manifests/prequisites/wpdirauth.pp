#
# == Class: wordpress::prequisites::wpdirauth
#
# Configure prequisites of the wpDirAuth plugin
#
class wordpress::prequisites::wpdirauth {

    include ::php::ldap
    include ::apache2::selinux::ldapauth
}
