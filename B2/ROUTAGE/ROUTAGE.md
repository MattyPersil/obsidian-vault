---
created:
  - "2025-09-29 13:58"
---

> [!info] Contact
> Nom Prénom : Monnier Matthieu
> Email : matthieumm444444@gmail.com
> Email Scolaire : matthieu.monnier@ecoles-epsi.net

---

- 2025-09-29 13:58 - Création initiale

---

> [!info] Sommaire
>
> ```table-of-contents
> 
> ```

---

# CONNEXION AU ROUTEUR

- CISCO 1900 Series On utilise MINICOM On se branche au routeur via un port mini usb On détecte quel port est utilisé

```bash
[  257.729556] usb 1-2: pl2303 converter now attached to ttyUSB0
```

Il est donc ici en `/dev/ttyACM0`,
On configure minicom avec

```bash
minicom -s
```

!\[\[Pasted image 20250929140348.png\]\]
On rentre le port dans Serial device et on remplace Bps/Par/Bits en 9600 pour éspérer communiquer avec le switch.
!\[\[Pasted image 20250929145355.png\]\]
Maintenant on *éspère* se connecter au switch en lancer `minicom` dans le terminal
On reset ensuite le router
!\[\[Router CISCO 1921.pdf\]\]

On crée le hostname

```
Router> enable
Router# configure terminal
Router(config)# hostname router-MMO
```

On configure le réseau, dhcp et nat

```
enable
configure terminal

! --- Configure G0/0 (LAN) ---
interface GigabitEthernet0/0
 description LAN Interface
 ip address 10.0.0.1 255.255.255.0
 no shutdown
 exit

! --- Configure DHCP Pool for LAN ---
ip dhcp excluded-address 10.0.0.1
ip dhcp pool LAN_POOL
 network 10.0.0.0 255.255.255.0
 default-router 10.0.0.1
 dns-server 8.8.8.8 8.8.4.4

! --- Configure G0/1 (WAN) ---
interface GigabitEthernet0/1
 description WAN Interface
 ip address dhcp
 no shutdown
 exit

! --- Enable NAT ---
access-list 1 permit 10.0.0.0 0.0.0.255

ip nat inside source list 1 interface GigabitEthernet0/1 overload

! --- Define NAT inside/outside interfaces ---
interface GigabitEthernet0/0
 ip nat inside
 exit

interface GigabitEthernet0/1
 ip nat outside
 exit

! --- (Optional) Save Configuration ---
end
write memory
```

Le pc connecté au router ping bien 8.8.8.8 !

# CONFIGURATION DU SWITCH

- Juniper EX2300 On configure le switch et ses vlans à l'aide de la doc de Léo : 
![[switch]]

On a donc :
```
set vlans LAN vlan-id 10
set vlans DMZ vlan-id 20
set vlans INTERMEDIAIRE vlan-id 30
set vlans ADMIN vlan-id 100
set vlans WAN vlan-id 200
```
J'ai ensuite setup des ports pour les vlans
```
set interfaces ge-0/0/0 unit 0 family ethernet-switching interface-mode trunk
set interfaces ge-0/0/0 unit 0 family ethernet-switching vlan members [10 20 30 100 200]

set interfaces ge-0/0/1 unit 0 family ethernet-switching interface-mode trunk
set interfaces ge-0/0/1 unit 0 family ethernet-switching vlan members LAN
set interfaces ge-0/0/2 unit 0 family ethernet-switching interface-mode trunk
set interfaces ge-0/0/2 unit 0 family ethernet-switching vlan members DMZ
set interfaces ge-0/0/3 unit 0 family ethernet-switching interface-mode trunk
set interfaces ge-0/0/3 unit 0 family ethernet-switching vlan members INTERMEDIAIRE
set interfaces ge-0/0/4 unit 0 family ethernet-switching interface-mode trunk
set interfaces ge-0/0/4 unit 0 family ethernet-switching vlan members ADMIN
```

Si on a besoin de le reset j'ai fais :

- Appyer sur le bouton du switch jusqu'à ce qu'il fasse sapin de noël
- S'y connecter, faire un `request system zeroize`
- Attendre qu'il s'éteigne et se rallume
- Le débrancher rebrancher
- Le switch est à l'état usine il faut ensuite set un mot de passe administrateur avec `set system root-authentication plain-text-password` Et on peut configurer les vlans sur le switch

# CONFIGURATION DU ROUTEUR POUR LES VLANS
Le setup de chaque pool pour le dhcp
```
router-MMO(config)#ip dhcp pool LAN                
router-MMO(dhcp-config)#network 10.0.10.0 255.255.255.0  
router-MMO(dhcp-config)#default-router 10.0.10.1          
router-MMO(dhcp-config)#dns-server 8.8.8.8                 
router-MMO(dhcp-config)#exit
router-MMO(config)#ip dhcp pool DMZ                
router-MMO(dhcp-config)#network 10.0.20.0 255.255.255.0  
router-MMO(dhcp-config)#default-router 10.0.20.1          
router-MMO(dhcp-config)#dns-server 8.8.8.8                 
router-MMO(dhcp-config)#exit
router-MMO(config)#ip dhcp pool INTERMEDIAIRE                
router-MMO(dhcp-config)#network 10.0.30.0 255.255.255.0  
router-MMO(dhcp-config)#default-router 10.0.30.1          
router-MMO(dhcp-config)#dns-server 8.8.8.8                 
router-MMO(dhcp-config)#exit
router-MMO(config)#ip dhcp pool ADMIN                
router-MMO(dhcp-config)#network 10.0.100.0 255.255.255.0  
router-MMO(dhcp-config)#default-router 10.0.100.1          
router-MMO(dhcp-config)#dns-server 8.8.8.8                 
router-MMO(dhcp-config)#exit
```
Le setup de chaque port pour les vlan
```
router-MMO(config)#interface GigabitEthernet0/0.10     
router-MMO(config-subif)#encapsulation dot1Q 10              
router-MMO(config-subif)#ip address 10.0.20.1 255.255.255.0  
router-MMO(config-subif)#exit
router-MMO(config)#interface GigabitEthernet0/0.20     
router-MMO(config-subif)#encapsulation dot1Q 20              
router-MMO(config-subif)#ip address 10.0.20.1 255.255.255.0  
router-MMO(config-subif)#exit
router-MMO(config)#interface GigabitEthernet0/0.30     
router-MMO(config-subif)#encapsulation dot1Q 30              
router-MMO(config-subif)#ip address 10.0.30.1 255.255.255.0  
router-MMO(config-subif)#exit
router-MMO(config)#interface GigabitEthernet0/0.100     
router-MMO(config-subif)#encapsulation dot1Q 100              
router-MMO(config-subif)#ip address 10.0.100.1 255.255.255.0  
router-MMO(config-subif)#exit
```

# CONFIGURATION D'UN DEUXIEME ROUTEUR EN HSRP
- On refait la config actuelle pour le VLAN10 (LAN)
- On a donc maintenant router-MMO et router2-MMO
- On met en place le HSRP dans le réseau GigabitEthernet0/0.10
router-MMO :
```
enable
configure terminal
interface GigabitEthernet0/0.10
ip address 10.0.10.252 255.255.255.0
no shut
standby 100 ip 10.0.10.1
standby 100 preempt
end
sh run int GigabitEthernet0/0.10
end
```
router2-MMO :
```
enable
configure terminal
interface GigabitEthernet0/0.10
ip address 10.0.10.253 255.255.255.0
standby 100 ip 10.0.10.1
standby 100 priority 110
standby 100 preempt
end
sh run int GigabitEthernet0/0.10
```

Pour vérifier la conf :
```
show standby GigabitEthernet0/0.10
```

# CONFIGURER LE HSRP DANS LE WIFI LABO

router-MMO :
```
enable
configure terminal
interface GigabitEthernet0/1
no shut
standby 100 ip 172.16.127.64
standby 100 preempt
end
sh run int GigabitEthernet0/1
end
```
router2-MMO :
```
enable
configure terminal
interface GigabitEthernet0/1
standby 100 ip 172.16.127.64
standby 100 priority 110
standby 100 preempt
end
sh run int GigabitEthernet0/1
```

Pour vérifier la conf :
```
show standby GigabitEthernet0/1
```

On configure ensuite du tracking pour correctement basculer entre les deux routeurs :
```
conf t
track 1 interface GigabitEthernet0/1 line-protocol

interface GigabitEthernet0/0.10
 standby 100 track 1 decrement 20
end
```

Si la bascule de fonctionne mais que la connexion ne passe pas vérifier les règles NAT

# PORT FORWARDING POUR UN SERVEUR WEB
- Dans le VLAN30 (INTERMEDIAIRE)
- On applique la même configuration de nat pour le vlan30 que pour le vlan10 (lan) pour pouvoir communiquer à l'extérieur (notamment installer un serveur apache)
- On applique également la même config pour le HSRP
On doit donc maintenant configurer du port forwarding pour les routers, qu'on accède au serveur apache depuis l'extérieur
```
ip nat inside source static tcp 10.0.30.4 80 interface GigabitEthernet0/1 80
```
Sur les 2 routers

# CONFIGURATION VLAN40 ET BDD
On crée le vlan sur les 2 routers avec
```
enable
conf t
ip dhcp pool VLAN40
network 10.0.40.0 255.255.255.0
default-router 10.0.40.1
dns-server 8.8.8.8
exit
int g0/0.40
encapsulation dot1Q 40
ip address 10.0.40.252 255.255.255.0
exit
```
```
enable
conf t
ip dhcp pool VLAN40
network 10.0.40.0 255.255.255.0
default-router 10.0.40.1
dns-server 8.8.8.8
exit
int g0/0.40
encapsulation dot1Q 40
ip address 10.0.40.253 255.255.255.0
exit
```

Configuration du switch pour le VLAN40

```
cli
configure
set vlans VLAN40 vlan-id 40
set interfaces ge-0/0/0 unit 0 family ethernet-switching vlan members VLAN40
set interfaces ge-0/0/23 unit 0 family ethernet-switching vlan members VLAN40
set interfaces ge-0/0/5 unit 0 family ethernet-switching interface-mode access
set interfaces ge-0/0/5 unit 0 family ethernet-switching vlan members VLAN40
commit
```
