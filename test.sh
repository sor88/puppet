#/bin/bash
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

if [ `lsb_release -r | sed 's/.\+:\s\+//'` = "12.04" ]; then
wget -q apt.puppetlabs.com/puppetlabs-release-pc1-precise.deb
dpkg -i puppetlabs-release-pc1-precise.deb
rm puppetlabs-release-pc1-precise.deb
apt-get install -y puppet
sleep 10
sed -i s/START=no/START=yes/g /etc/default/puppet
sed -i "/\/var\/log\/puppet/a \server=$namepuppet" /etc/puppet/puppet.conf
puppet agent --test
else
(
wget -q apt.puppetlabs.com/puppetlabs-release-trusty.deb
echo 5
dpkg -i puppetlabs-release-trusty.deb > /dev/null
echo 10
rm puppetlabs-release-trusty.deb*
echo 15
apt-get install -y puppet > .log.log
#########################################################################
#(
progress="30"
while (true)
do
proc=$(ps aux | grep -v grep | grep -e "apt-get")
if [ "$proc" = "" ]; then break; fi
sleep 1
progress=$(expr $progress + 2)
done;
##########################################################################
rm .log.log
#clear
sed -i s/START=no/START=yes/g /etc/default/puppet
sed -i "/\/var\/log\/puppet/a \server=$namepuppet" /etc/puppet/puppet.conf
sed -i 's/templatedir/#templatedir/' /etc/puppet/puppet.conf
echo 100
puppet agent --test
) | whiptail --title "Установка Puppet клиента" --gauge "Пожалуйста подождите, роняем цены на нефть" 7 70 1

fi

else
echo "Выход"
exit
fi

else
echo "Отмена запуска"
fi
