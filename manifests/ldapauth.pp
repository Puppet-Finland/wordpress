#
# == Class: wordpress::ldapauth
#
# Make Wordpress authenticate from LDAP. The parameter documentation has been
# more or less copied from wpDirAuth module's own documentation.
#
# == Parameters
#
# [*controllers*]
#   The DNS name or IP address of the directory server(s). If you define several 
#   servers separate them with commas.
# [*base_dn*]
#   The base DN for carrying out LDAP searches. For example 'cn=Users, dc=smb, 
#   dc=domain, dc=com'.
# [*pre_bind_user*]
#   A valid user account/DN to pre-bind as if your LDAP server does not allow 
#   anonymous profile searches, or requires a user with specific privileges to 
#   search. For example 'CN=Administrator,CN=Users,DC=smb,DC=domain,DC=com'
# [*pre_bind_password*]
#   Enter a password for the above Bind DN if a value is needed.
# [*filter*]
#   The attribute that identifies the user. For example 'cn'.
# [*institution*]
#   Name of your institution/company. Displayed on the login screen.
# [*login_screen_message*]
#   A message displayed on the login screen, underneath the username/password 
#   fields.
# [*change_pass_msg*]
#   Displayed wherever user passwords can be changed, for directory users only.
# [*enable_ssl*]
#   Use encryption when WordPress connects to the directory server(s). Valid 
#   values are 0 ('no', default) and 1 ('yes').
# [*require_ssl*]
#   Force the WordPress login screen to require encryption. Valid values are 0 
#   ('no', default) and 1 ('yes').
# [*account_suffix*]
#   Suffix to be automatically appended to the username if desired. e.g. 
#   '@domain.com'. Defaults to undef.
# [*tos*]
#   Ask directory users to agree to terms of services. Valid values are 0 ('no', 
#   default) and 1 ('yes').
# [*use_groups*]
#   Use LDAP groups. Valid values are 0 ('no', default) and 1 ('yes').
# [*groups*]
#   Enter each group CN that the user must be a member of in order to 
#   authenticate. Separate values with commas. Defaults to undef.
# [*marketing_ssoid*]
#   Marketing name for Institutional Single-Sign-On ID. This is how your 
#   institution/company refers to the single-sign-on ID you use. Defaults to 
#   undef.
#
# == Examples
#
# An example using Hiera, where Wordpress authenticates against a Samba 4 AD DC 
# server.
#
#   ---
#   classes:
#     - apache2
#     - mysql
#     - wordpress
#     - wordpress::ldapauth
#
#   # On CentOS 7 Apache2 is not started automatically
#   apache2::ensure_service: 'running'
#
#   # Generic Wordpress settings
#   wordpress::dbpassword: 'your_db_password'
#   wordpress::wpadmin: 'admin'
#   wordpress::wpadmin_password: 'your_wp_admin_password'
#   wordpress::wpadmin_email: 'admin@domain.com'
#   wordpress::wpurl: 'http://intra.acme.com/wordpress'
#   wordpress::wptitle: 'Acme Oy Intranet'
#
#   # Wordpress LDAP authentication settings
#   wordpress::ldapauth::controllers: '10.84.44.5'
#   wordpress::ldapauth::base_dn: 'CN=Users,DC=smb,DC=acme,DC=com'
#   wordpress::ldapauth::pre_bind_user: 'CN=Administrator,CN=Users,DC=smb,DC=acme,DC=com'
#   wordpress::ldapauth::pre_bind_password: 'samba_admin_password'
#   wordpress::ldapauth::filter: 'cn'
#   wordpress::ldapauth::institution: 'Acme, Inc'
#   wordpress::ldapauth::login_screen_msg: 'Please login with your Acme, Inc credentials'
#   wordpress::ldapauth::change_pass_msg: 'Passwords must match Acme, Inc's policies'
#   wordpress::ldapauth::enable_ssl: 0
#   wordpress::ldapauth::require_ssl: 0
#
class wordpress::ldapauth
(
    $controllers,
    $base_dn,
    $pre_bind_user,
    $pre_bind_password,
    $filter,
    $institution,
    $login_screen_msg,
    $change_pass_msg,
    $enable_ssl = 0,
    $require_ssl = 0,
    $account_suffix = undef,
    $tos = 0,
    $use_groups = 0,
    $groups = undef,
    $marketing_ssoid = undef

) inherits wordpress::params
{

    include ::wordpress::prequisites::wpdirauth
    include ::wordpress::install::wpdirauth

    class { '::wordpress::config::wpdirauth':
        enable_ssl        => $enable_ssl,
        require_ssl       => $require_ssl,
        controllers       => $controllers,
        base_dn           => $base_dn,
        pre_bind_user     => $pre_bind_user,
        pre_bind_password => $pre_bind_password,
        account_suffix    => $account_suffix,
        filter            => $filter,
        institution       => $institution,
        login_screen_msg  => $login_screen_msg,
        change_pass_msg   => $change_pass_msg,
        tos               => $tos,
        use_groups        => $use_groups,
        groups            => $groups,
        marketing_ssoid   => $marketing_ssoid,
    }
}
