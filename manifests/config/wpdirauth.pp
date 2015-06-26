#
# == Class: wordpress::config::wpdirauth
#
# Configure the wpDirAuth plugin
#
class wordpress::config::wpdirauth
(
    $enable_ssl,
    $require_ssl,
    $controllers,
    $base_dn,
    $pre_bind_user,
    $pre_bind_password,
    $account_suffix,
    $filter,
    $institution,
    $login_screen_msg,
    $change_pass_msg,
    $tos,
    $use_groups,
    $groups,
    $marketing_ssoid

) inherits wordpress::params
{

    Wp::Option {
        ensure => 'equal',
        require => Class['wordpress::install::wpdirauth'],
    }

    wp::option { 'dirAuthEnable':    value => 1, }
    wp::option { 'dirAuthEnableSsl': value => $enable_ssl, }
    wp::option { 'dirAuthRequireSsl': value => $require_ssl, }
    wp::option { 'dirAuthControllers': value => $controllers , }
    wp::option { 'dirAuthBaseDn': value => $base_dn, }
    wp::option { 'dirAuthPreBindUser': value => $pre_bind_user , }
    wp::option { 'dirAuthPreBindPassword': value => $pre_bind_password , }
    wp::option { 'dirAuthAccountSuffix': value => $account_suffix , }
    wp::option { 'dirAuthFilter': value => $filter, }
    wp::option { 'dirAuthInstitution': value => $institution, }
    wp::option { 'dirAuthLoginScreenMsg': value => $login_screen_msg, }
    wp::option { 'dirAuthChangePassMsg': value => $change_pass_msg, }
    wp::option { 'dirAuthUseGroups': value => $use_groups, }
    wp::option { 'dirAuthGroups': value => $groups, }
    wp::option { 'dirAuthMarketingSSOID': value => $marketing_ssoid, }

}
