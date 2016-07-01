#
# == Class: wordpress::config::mysql
#
# Configure the MySQL database for Wordpress
#
class wordpress::config::mysql
(
    $ensure,
    $dbname,
    $dbuser,
    $dbpassword,
)
{
    mysql::database { 'wordpress':
        ensure            => $ensure,
        use_root_defaults => true,
    }

    mysql::grant { 'wpuser':
        ensure     => $ensure,
        user       => $dbuser,
        host       => 'localhost',
        password   => $dbpassword,
        database   => $dbname,
        privileges => 'ALL',
        require    => Mysql::Database['wordpress'],
    }
}
