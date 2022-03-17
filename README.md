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
    - name: Setting timezone
    - name: Debug /etc/hosts
    - name: Update apt repo and cache on all Debian/Ubuntu boxes
        # In case of invalid signature in the update:
            # sudo apt-key list | grep -A 1 expired
            # sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys <KEY>
    - name: Upgrade all packages on servers
    - name: configurando FQDN
    - name: Alterando hosts
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
    - name: criando grupo
    - name: Adicionando o user bigbluebutton no grupo scalelite-spool
    - name: Criando o diretório /mnt/scalelite-recordings
    - name: Montando o NFS
    - name: Download script scalelite_post_publish
    - name: Download export_presentation.rb # bbb-recording-exporter
    - name: Download interval_tree.rb
    - name: Criando scalelite.yml
    - name: Create a directory if it does not exist # BigBlueButton Exporter
    - name: Install aptitude using apt
    - name: Install required system packages
    - name: Add Docker GPG apt Key
    - name: Add Docker Repository
    - name: Update apt and install docker-ce
    - name: Update apt and install docker-compose
    - name: Create docker-compose file
    - name: print secret
    - name: captura a saida secret
    - name: Criando secrets.env
    - name: docker-compose
    - name: adicionadn user
    - name: Copy monitoring.nginx
    - name: Create a directory if it does not exist # BigBlueButton Exporter - node_exporter
    - name: Create docker-compose file
    - name: docker-compose 
    - name: Nginx exporter
```
**SSH**
```
sh-copy-id -i ~/.ssh/id_rsa.pub user@ip
```
**Run**
```
ansible all -m ping

ansible-playbook -i hosts playbook.yml -K
```
