```Lab_3

2.1

2.1.1
mkdir ~/test
cd ~/test
touch file
ls -l file
2.1.2
chmod 000 file
echo "Test smth" > file
cat file
2.1.3
chmod 600 file       or        chmod u+w file
echo "Add smth to the file" > file
cat file
2.1.4
chmod g+r file
cat file
2.1.5
chmod u+r file
cat file
2.1.6
mkdir ~/test/dir
echo "Some text" > ~/test/dir/new_file
ls -l ~/test/dir
2.1.7
chmod a-x ~/test/dir
cd ~
cat ~/test/dir/new_file
rm ~/test/dir/new_file

chmod a+x ~/test/dir
2.1.8
chown root ~/test/file
2.1.9
umask 077
touch ~/test/file_strict
ls -l ~/test/file_strict
2.1.10
umask 000
touch ~/test/file_open
ls -l ~/test/file_open

umask 022
2.1.11
sudo -i
chown root /home/polina/test/file
chmod 400 /home/polina/test/file        or         q+r,a+w....etc.
exit
2.1.12
cat ~/test/file
chmod 444 /home/polina/test/file
exit
cat ~/test/file

2.2
2.2.1
id
2.2.2
grep polina /etc/passwd
getent group polina
2.2.3
sudo groapadd labgroup
getent group labgroup
2.2.4
sudo useradd -m -s /bin/bash
id labuser
grep labuser /etc/passwd
2.2.5
sudo passwd labuser
su - labuser
id
pwd
exit
2.2.6
su - labuser
touch ~/labuser_test_file
ls -l ~/labuser_test_file
exit
2.2.7
sudo usermod -aG labgroup labuser
id labuser

su - labuser
id
exit
2.2.8
sudo useradd -m -s /bin/bash labuser2
sudo usermod -aG labgroup labuser2

id labuser
id labuser2
2.2.9
sudo mkdir -p /tmp/lab_shared
sudo chown root:labgroup /tmp/lab_shared
sudo chmod 770 /tmp/lab_shared
sudo ls -ld /tmp/lab_shared
sudo -u labuser touch /tmp/lab_shared/file_by_user1
sude -u labuser2 touch /tmp/lab_shared/file_by_user2
ls -l tmp/lab_shared
2.2.10
ls -l /tmp/lab_shared/file_by_user1
sudo -u labuser2 cat /tmp/lab_shared/file_by_user1
sudo -u labuser2 echo "smth" > /tmp/lab_shared/file_by_user1
sudo -u labuser2 rm /tmp/lab_shared/file_by_user1
2.2.11
sudo chmod g+s /tmp/lab_shared
sudo ls -ld /tmp/lab_shared
sudo -u labuser touch /tmp/lab_shared/sgid_file_user1
sudo -u labuser2 touch /tmp/lab_shared/sgid_file_user2
sudo ls -l /tmp/lab_shared/
2.2.12
sudo mkdir -p /tmp/lab_sticky
sudo chmod 777 /tmp/lab_sticky
sudo chmod +t /tmp/lab_sticky
sudo ls -ld /tmp/lab_sticky
sudo -u labuser touch /tmp/lab_sticky/sticky_file_user1
sudo -u labuser2 touch /tmp/lab_sticky/sticky_file_user2
sudo -u labuser2 rm /tmp/lab_sticky/lab_file_user1
2.2.13
sudo usermod -L labuser
su - labuser
sudo usermod -U labuser
su - labuser
exit
2.2.14
sudo chage -l labuser
sudo chage -d 0 labuser
sudo chage -l labuser
su - labuser
exit
2.2.15
sudo usermod -s /bin/sh labuser
grep labuser /etc/passwd
sudo usermod -s bin/bash labuser
grep labuser /etc/passwd
2.2.16
sudo userdel labuser2
ls -ld /home/labuser2
ls -l /home/labuser2
2.2.17
cat /etc/passwd
grep -E '^(daemon|sys|sync):' /etc/passwd
grep '^daemon:' /etc/passwd
grep '^polina:' /etc/passwd
2.2.18
grep -E '^(UID_MIN|UID_MAX|SYS_UID_MIN|SYS_UID_MAX)' /etc/login.defs
cut -d: -f1,3 /etc/passwd | head -20
2.2.19
sudo useradd -m testuser
sudo useradd --system testsystem
grep -E '^(testuser|testsystem):' /etc/passwd
id testuser
id testsystem
2.2.20
sudo userdel testsystem
sudo useradd --system -m testsystem
ls -ld /home/testsystem
ls -ld /testsystem
grep '^testsystem:' /etc/passwd
2.2.21
grep 'nologin$' /etc/passwd | head -5
grep 'false$' /etc/passwd | head -5
which nologin
which false
ls -l /usr/sbin/nologin
ls -l /bin/false
2.2.22
sudo usermod -s /usr/sbin/nologin testuser
grep '^testuser:' /etc/passwd
su - testuser
sudo -u testuser whoami
2.2.23
sudo usermod -s /bin/false testuser
grep '^testuser:' /etc/passwd
su - testuser
2.2.24
sudo usermod -s /bin/bash testuser
grep '^testuser:' /etc/passwd
su - testuser
exit
2.2.25
sudo usermod -s /bin/ls testuser
grep '^testuser:' /etc/passwd
su - testuser
sudo usermod -s /bin/bash testuser
grep '^testuser:' /etc/passwd
2.2.26
sudo groupadd --system testsystemgroup
sudo groupadd testgroup
getent group testsystemgroup
getent group testgroup
2.2.27
grep -E '^(GID_MIN|GID_MAX|SYS_GID_MIN|SYS_GID_MAX)' /etc/login.defs
2.2.28
sudo useradd --system -g testsystemgroup -s /usr/sbin/nologin serviceuser
grep '^serviceuser:' /etc/passwd
ls -ld /home/serviceuser
2.2.29
su - testuser
sudo id
exit
2.2.30
sudo visundo 

testuser ALL=(root) /usr/bin/id

su - testuser
sudo id     
sudo ls /root
exit
2.2.31
sudo visudo
testuser ALL=(root) /usr/bin/id, /usr/bin/whoami
su - testuser
sudo whoami      # Должно сработать и вывести "root"
sudo cat /etc/shadow # Должно отказать
exit
2.2.32
sudo groupadd testadmins
# %testadmins ALL=(root) /usr/bin/id
sudo visudo
sudo usermod -aG testadmins testuser
su - testuser
sudo id
exit
sudo gpasswd -d testuser testadmins
su - testuser
sudo id
exit
2.2.33
sudo cp /etc/login.defs /etc/login.defs.backup

grep -E '^[^#]' /etc/login.defs | grep -E '(UID_MIN|UID_MAX|SYS_UID|GID_MIN|GID_MAX|SYS_GID|CREATE_HOME|UMASK|USERGROUPS_ENAB|SHELL|HOME)'
2.2.34
grep '^UID_MIN' /etc/login.defs
sudo sed -i 's/^UID_MIN.*/UID_MIN 2000/' /etc/login.defs
sudo useradd -m configuser1
id configuser1
sudo userdel -r configuser1
sudo sed -i 's/^UID_MIN.*/UID_MIN 1000/' /etc/login.defs
2.2.35
grep -E '^SYS_UID_(MIN|MAX)' /etc/login.defs
sudo sed -i 's/^SYS_UID_MIN.*/SYS_UID_MIN 500/' /etc/login.defs
sudo sed -i 's/^SYS_UID_MAX.*/SYS_UID_MAX 599/' /etc/login.defs
sudo useradd --system sysconfig1
sudo useradd --system sysconfig2
sudo useradd --system sysconfig3
id sysconfig1; id sysconfig2; id sysconfig3
sudo userdel sysconfig1; sudo userdel sysconfig2; sudo userdel sysconfig3
sudo sed -i 's/^SYS_UID_MIN.*/SYS_UID_MIN 100/' /etc/login.defs
sudo sed -i 's/^SYS_UID_MAX.*/SYS_UID_MAX 999/' /etc/login.defs
2.2.36
grep -E '^GID_(MIN|MAX)' /etc/login.defs
sudo sed -i 's/^GID_MIN.*/GID_MIN 2000/' /etc/login.defs
sudo groupadd configgroup1
getent group configgroup1
sudo groupdel configgroup1
sudo sed -i 's/^GID_MIN.*/GID_MIN 1000/' /etc/login.defs
2.2.37
grep -E '^SYS_GID_(MIN|MAX)' /etc/login.defs
sudo sed -i 's/^SYS_GID_MIN.*/SYS_GID_MIN 600/' /etc/login.defs
sudo sed -i 's/^SYS_GID_MAX.*/SYS_GID_MAX 699/' /etc/login.defs
sudo groupadd --system sysgroup1
sudo groupadd --system sysgroup2
getent group sysgroup1; getent group sysgroup2
sudo groupdel sysgroup1; sudo groupdel sysgroup2
sudo sed -i 's/^SYS_GID_MIN.*/SYS_GID_MIN 100/' /etc/login.defs
sudo sed -i 's/^SYS_GID_MAX.*/SYS_GID_MAX 999/' /etc/login.defs
2.2.38
grep 'CREATE_HOME' /etc/login.defs
ORIG_CREATE_HOME=$(grep '^[#]*CREATE_HOME' /etc/login.defs)
sudo sed -i 's/^#*CREATE_HOME.*/CREATE_HOME yes/' /etc/login.defs
grep '^CREATE_HOME' /etc/login.defs
sudo useradd homeuser1
ls -ld /home/homeuser1
sudo sed -i 's/^CREATE_HOME.*/CREATE_HOME no/' /etc/login.defs
grep '^CREATE_HOME' /etc/login.defs
sudo useradd homeuser2
ls -ld /home/homeuser2
sudo userdel homeuser1
sudo userdel homeuser2
sudo sed -i "s/^CREATE_HOME.*/$ORIG_CREATE_HOME/" /etc/login.defs
grep 'CREATE_HOME' /etc/login.defs
2.2.39
sudo sed -i 's/^#*CREATE_HOME.*/CREATE_HOME yes/' /etc/login.defs
sudo useradd --system syshome1
HOME_DIR1=$(grep '^syshome1:' /etc/passwd | cut -d: -f6)
echo "Запись в passwd для syshome1: $HOME_DIR1"
ls -ld "$HOME_DIR1"  # Ожидаемый результат: No such file or directory
sudo useradd --system -m syshome2
HOME_DIR2=$(grep '^syshome2:' /etc/passwd | cut -d: -f6)
echo "Запись в passwd для syshome2: $HOME_DIR2"
ls -ld "$HOME_DIR2"  # Ожидаемый результат: каталог существует
sudo userdel syshome1
sudo userdel -r syshome2  # флаг -r удалит каталог, созданный с помощью -m
2.2.40
grep -E '^(UMASK|HOME_MODE)' /etc/login.defs
sudo useradd -m umask_user1
ls -ld /home/umask_user1
ORIG_UMASK=$(grep '^UMASK' /etc/login.defs | awk '{print $2}')
sudo sed -i 's/^UMASK.*/UMASK 002/' /etc/login.defs
sudo useradd -m umask_user2
ls -ld /home/umask_user2
echo "umask_user1:"; ls -ld /home/umask_user1
echo "umask_user2:"; ls -ld /home/umask_user2
sudo userdel -r umask_user1
sudo userdel -r umask_user2
sudo sed -i "s/^UMASK.*/UMASK $ORIG_UMASK/" /etc/login.defs
grep '^UMASK' /etc/login.defs
2.2.41
grep '^USERGROUPS_ENAB' /etc/login.defs
sudo useradd -m testgroup_yes
id testgroup_yes
sudo sed -i 's/^USERGROUPS_ENAB.*/USERGROUPS_ENAB no/' /etc/login.defs
sudo useradd -m testgroup_no
id testgroup_no
sudo userdel -r testgroup_yes
sudo userdel -r testgroup_no
sudo sed -i 's/^USERGROUPS_ENAB.*/USERGROUPS_ENAB yes/' /etc/login.defs
2.2.42
grep '^SHELL' /etc/login.defs
sudo sed -i 's|^SHELL.*|SHELL /bin/sh|' /etc/login.defs
sudo useradd -m defaultuser1
grep '^defaultuser1:' /etc/passwd
sudo userdel -r defaultuser1
sudo sed -i 's|^SHELL.*|SHELL /bin/bash|' /etc/login.defs
2.2.43
grep '^HOME' /etc/login.defs
sudo sed -i 's|^HOME.*|HOME /opt|' /etc/login.defs
sudo useradd -m defaultuser2
grep '^defaultuser2:' /etc/passwd
ls -ld /opt/defaultuser2
sudo userdel -r defaultuser2
sudo sed -i 's|^HOME.*|HOME /home|' /etc/login.defs

```
















