# Ansible script for update BigBlueButton
```
git clone https://github.com/henriquebol/ansible-update-bbb.git
```
**Ansible (ubuntu)**
```
sudo apt update
sudo apt install software-properties-common
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```
**Role**
```
ansible-galaxy install n0emis.bigbluebutton
```
**Vars**
```
bbb_state: latest
bbb_coturn_enable: no
bbb_mute_on_start: no
bbb_letsencrypt_email: 
bbb_greenlight_enable: no
bbb_freeswitch_external_ip: "{{ inventory_hostname }}"
bbb_turn_servers:
    -  server: 
       port: 
       secret: 
       tls: false
    -  server: 
       port: 
       secret: 
       tls: true
```
**Tasks**
```
    - name: "Debug facts"
    - name: Check/Modify /etc/hosts (commented)
    - name: Debug /etc/hosts
    - name: Update apt repo and cache on all Debian/Ubuntu boxes
        # In case of invalid signature in the update:
            # sudo apt-key list | grep -A 1 expired
            # sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys <KEY>
    - name: Upgrade all packages on servers
    - name: Check if a reboot is needed on all servers
    - name: Reboot the box if kernel updated
    - name: BigBluebutton install
    - name: Copy default pdf
    - name: Copy favicon
    - name: Copy logo
    - name: Copy and extract audio (pt_BR)
    - name: Recursively change ownership of audio directory
    - name: Copy cron bbb-recording-cleanup
    - name: install rest-client gem 
    - name: Copy ruby download script 
    - name: Copy download script
    - name: Modify bigbluebutton.properties (defaultWelcomeMessage, logoutURL, joinViaHTML5Client, muteOnStart)
    - name: Modify settings.yml (clientTitle, copyright, helpLink)
    - name: Modify layout (head.html)
    - name: Add cron job for certbot/Letsencrypt renewal (commented)
        # Manual installation:
            # sudo crontab -e
            # 30 2 * * 1 /usr/bin/certbot renew >> /var/log/le-renew.log
            # 35 2 * * 1 /bin/systemctl reload nginx
    - name: Add cron job for restart nginx (commented)
    - name: Check crontab (letsencrypt)
    - name: Remove bbb-demo
    - name: Restart bbb-html5
    - name: Restart bbb
    - name: Check bbb
    - name: Debug Result
```
**SSH**
```
sh-copy-id -i ~/.ssh/id_rsa.pub user@ip
```
**Run**
```
ansible-playbook -i hosts playbook.yml -K
```
