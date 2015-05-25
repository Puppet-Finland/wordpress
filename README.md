# wordpress

A Puppet module for managing Wordpress. The goal of this module is to setup a 
single Wordpress site based on Wordpress packages available in the 
distribution's own software repositories. If you need a multi-site setup or very 
up-to-date version of Wordpress please use one of the other Wordpress Puppet 
modules aimed at that particular purpose.

# Module usage

* [Class: wordpress](manifests/init.pp)

# Dependencies

See [metadata.json](metadata.json).

# Operating system support

This module has been tested on

* CentOS 7

Currently Debian-based operating systems will only work if $manage_config is set 
to 'no', because the wordpress::config subclasses are somewhat CentOS 
7-specific.

For details see [params.pp](manifests/params.pp).

# License

While this module is mostly BSD-licensed (see file LICENSE), the
wp-keys.php.erb file has been taken from
[another Wordpress Puppet module](https://github.com/hunner/puppet-wordpress)
that is licensed under the Apache 2.0 license. The file in question is (C) 2013
Hunter Haugen.
