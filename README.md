# Ansible script for update BigBlueButton

Ansible (ubuntu)
* sudo apt update
* sudo apt install software-properties-common
* sudo apt-add-repository --yes --update ppa:ansible/ansible
* sudo apt install ansible

Role
* ansible-galaxy install n0emis.bigbluebutton

Vars
* bbb_state: latest
* bbb_coturn_enable: no
* bbb_mute_on_start: no
* bbb_letsencrypt_email: 
* bbb_greenlight_enable: no
* bbb_freeswitch_external_ip: "{{ inventory_hostname }}"
* bbb_turn_servers:
  *  server: 
  *  port: 
  *  secret: 
  *  tls: false
  *  server: 
  *  port: 
  *  secret: 
  *  tls: true

Hosts

Run
* sudo ansible-playbook -i hosts playbook.yml -K
