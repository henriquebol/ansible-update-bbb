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
    - name: Update apt repo and cache on all Debian/Ubuntu boxes
    - name: Upgrade all packages on servers
    - name: Check if a reboot is needed on all servers
    - name: Reboot the box if kernel updated
    - name: Check/Modify /etc/hosts (pendent)
    - name: BigBluebutton install
    - name: Modify bigbluebutton.properties (pendent)
    - name: Modify settings.yml (pendent)
    - name: Modify head.html (pendent)
    - name: Letsencrypt automatic renewal (pendent)
    - name: Copy default pdf
    - name: Copy favicon
    - name: Copy logo
    - name: Copy and extract audio (pt_BR)
    - name: Recursively change ownership of audio directory
    - name: Restart bbb-html5
    - name: Restart bbb
    - name: Check bbb
    - name: Debug Result
```
**Run**
```
sudo ansible-playbook -i hosts playbook.yml -K
```
