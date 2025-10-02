
```bash
cli
configure
172.16.119.4
# On commence par supprimer le DHCP si il est configuré sur l'interface de management
delete interfaces vme unit 0 family inet dhcp

# 1) Attribuer l’adresse IP à l’interface vme (unité 0)
set interfaces vme unit 0 family inet address 172.16.118.200/16

# 2) Configurer la route par défaut pour la routing-instance mgmt_junos
set routing-instances mgmt_junos routing-options static route 0.0.0.0/0 next-hop 172.16.255.254

# 3) Activer SSH (et/ou autres services)
set system services ssh

# 4) Indiquer qu’on utilise la management-instance
set system management-instance

# 5) Définir un mot de passe root (si pas déjà fait)
set system root-authentication plain-text-password
# (Entrer deux fois le mot de passe)

commit

#utilisation de ssh
set system services ssh
commit
#on configure un user
set system login user admin class super-user authentication plain-text-password
commit
#configurer les vlans sur les interfaces du switch
# On configure un port en access sur le vlan10

set interfaces ge-0/0/1 unit 0 family ethernet-switching interface-mode access
set interfaces ge-0/0/1 unit 0 family ethernet-switching vlan members VLAN10

# On valide

commit

#vlan 
set vlans VLAN10 vlan-id 10 ect 
set interfaces ge-0/0/2 unit 0 family ethernet-switching interface-mode trunk
set interfaces ge-0/0/5 unit 0 family ethernet-switching vlan members [10 11 12 13]

```

