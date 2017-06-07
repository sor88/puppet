class zabbix-client {
        package { "zabbix-agent": ensure => "installed"; 
                }
}



class zabbix-client::zabconf {
file { '/etc/zabbix/zabbix_agentd.conf':
  ensure  => file,
  content => template('zabbix-client/zabbix.conf.erb'),
}

}

