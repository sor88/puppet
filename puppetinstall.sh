#/bin/bash
version=$(lsb_release -c | sed 's/.\+:\s\+//')

f1(){
				progress="30"
				while (true)
				do
				proc=$(ps aux | grep -v grep | grep -e "apt-get")
				if [ "$proc" = "" ]; then break; fi
				sleep 1
				progress=$(expr $progress + 2)
				done;

}
installp12(){
(
                                wget -q apt.puppetlabs.com/puppetlabs-release-pc1-$version.deb
                                echo 5
                                dpkg -i puppetlabs-release-pc1-$version.deb > /dev/null
                                echo 10
                                rm puppetlabs-release-pc1-$version.deb
                                echo 15
                                apt-get install -y puppet > .log.log
                                f1
                                sleep 2
                                sed -i s/START=no/START=yes/g /etc/default/puppet
                                sed -i "/\/var\/log\/puppet/a \server=$namepuppet" /etc/puppet/puppet.conf
                                sleep 10
				puppet agent --enable
				puppet agent --test
                                ) | whiptail --title "Установка Puppet клиента" --gauge "Пожалуйста подождите! В сбербанке очередь." 7 70 1
                                rm .log.log
                                exit
}
installp(){
(
                                wget -q apt.puppetlabs.com/puppetlabs-release-pc1-$version.deb
                                echo 5
                                dpkg -i puppetlabs-release-pc1-$version.deb > /dev/null
                                echo 10
                                rm puppetlabs-release-pc1-$version.deb
                                echo 15
                                apt-get install -y puppet > .log.log
                                f1
                                sleep 2
#                                sed -i s/START=no/START=yes/g /etc/default/puppet
                                sed -i "/\/var\/log\/puppet/a \server=$namepuppet" /etc/puppet/puppet.conf
                                sleep 10
                                puppet agent --enable
                                puppet agent --test
                                ) | whiptail --title "Установка Puppet клиента" --gauge "Пожалуйста подождите! В сбербанке очередь." 7 70 1
                                rm .log.log
                                exit
}

installp2(){
(
                                wget -q apt.puppetlabs.com/puppetlabs-release-$version.deb
                                echo 5
                                dpkg -i puppetlabs-release-$version.deb > /dev/null
                                echo 10
                                rm puppetlabs-release-$version.deb
                                echo 15
                                apt-get install -y puppet > .log.log
                                f1
                                sleep 2
                                sed -i "/\/var\/log\/puppet/a \server=$namepuppet" /etc/puppet/puppet.conf
				sleep 10
				puppet agent --enable
				puppet agent --test
                                ) | whiptail --title "Установка Puppet клиента" --gauge "Пожалуйста подождите! В сбербанке очередь." 7 70 1
                                rm .log.log
                                exit
}
installp3(){
(
                                wget -q apt.puppetlabs.com/puppet6-release-$version.deb
                                echo 5
                                dpkg -i puppet6-release-$version.deb > /dev/null
                                echo 10
                                rm puppet6-release-$version.deb
                                echo 15
                                apt-get install -y puppet > .log.log
                                f1
                                sleep 2
                                sed -i "/\/var\/log\/puppet/a \server=$namepuppet" /etc/puppet/puppet.conf
				sleep 10
				puppet agent --enable
				puppet agent --test
                                ) | whiptail --title "Установка Puppet клиента" --gauge "Пожалуйста подождите! В сбербанке очередь." 7 70 1
                                rm .log.log
                                exit
}
installp4(){
(
                                wget -q apt.puppetlabs.com/puppetlabs-release-pc1-stretch.deb
                                echo 5
                                dpkg -i puppetlabs-release-pc1-stretch.deb > /dev/null
                                echo 10
                                rm puppet6-release-$version.deb
                                echo 15
                                apt-get install -y puppet > .log.log
                                f1
                                sleep 2
                                sed -i "/\/var\/log\/puppet/a \server=$namepuppet" /etc/puppet/puppet.conf
                                sleep 10
                                puppet agent --enable
                                puppet agent --test
                                ) | whiptail --title "Установка Puppet клиента" --gauge "Пожалуйста подождите! В сбербанке очередь." 7 70 1
                                rm .log.log
                                exit
}

if (whiptail --title "Подготовка рабочей станции " --yesno "Запуск сценария установки" 10 60  "введите имя ПК") then
		namehost=$(whiptail --title "Установка HostName" --inputbox "Введите имя компьютера" 10 60 HostName 3>&1 1>&2 2>&3)
		exitstatus=$?
			if [ $exitstatus = 0 ]; then
				echo $namehost > /etc/hostname
			else
				echo "Отмена"
				exit
			fi
namepuppet=$(whiptail --title "Введите адрес сервера Puppet" --inputbox "Введите имя сервера Puppet" 10 60 ServerName 3>&1 1>&2 2>&3)
exitstatus=$?
			if [ $exitstatus = 0 ]; then
testversion=$(lsb_release -r | sed 's/.\+:\s\+//');
			case $testversion in
			12.04)
			installp12
			;;
			14.04)
			installp
			;;
			16.04)
			installp
			;;
			18.04)
			installp3
			;;
			8.*)
			installp2
			;;
			7.*)
			installp2
			;;
			orel)
			installp4
			;;
			testing)
			version=$(lsb_release -r | sed 's/.\+:\s\+//')
			installp2
			;;
			*)
				echo "Выход"
				exit
			;;
	esac
			fi
else
echo "Отмена запуска"
fi
#exit

