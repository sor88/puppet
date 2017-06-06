class veeam {

                wget::fetch { 'https://download2.veeam.com/veeam-release-deb_1.0_amd64.deb':
                destination => '/tmp/',
}
#               wget::fetch { 'http://repository.veeam.com/backup/linux/agent/dpkg/debian/x86_64/pool/veeam/v/veeam/veeam_1.0.1.364_amd64.deb':
#               destination => '/tmp/',
#}


}


class veeam::repon {

package { "veeam-release-deb_1.0_amd64.deb":
                provider => dpkg,
                ensure => latest,
                source => "/tmp/veeam-release-deb_1.0_amd64.deb"
        }

}



class veeam::install {


exec { "apt-update":
    command => "/usr/bin/apt-get update"
}
         package {
                "veeam": ensure => "installed";
                 }
}
