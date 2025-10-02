---
created:
  - "2025-02-12 16:07"
---
>[!info] Contact 
Author : @MattyPersil
Email : matthieumm444444@gmail.com

---
- 2025-02-12 16:07 - Création initiale
---

> [!info] Sommaire
> ```table-of-contents
> ```

---
# Intro
## Goals
- Create CP
- Install Rust
- Install Serenity
- Start a bot for the first time
## Sources :
- https://linuxcapable.com/how-to-install-rust-on-debian-linux/
# Create CP
I'm using proxmox, creating a CP on debian 12 bookworm, and connecting to it using SSH.
# Install Rust
- Updating debian
```bash
sudo apt update && sudo apt upgrade
```
- Installing Rust required packages
```bash
sudo apt install curl build-essential gcc make
```
- Installing Rust via curl
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```
- Activating rust environnement
```bash
source ~/.cargo/env
```
- Confirmating rust installation
```bash
rustc -V
```
# Create and clone git repo
// Optional //
- Create repo git on github
- clone the git repo
```bash 
git clone https://github.com/MattyPersil/Nyx_bot.git
```
- Additionnally add ssh keys to not enter login password each time
- Generate an ssh key
```bash
ssh-keygen -t ed25519
```
- Add the ed25519.pub to github in setting > SSH and GPG Keys > New SSH Key
- Run this command
```bash
git remote set-url origin git@github.com:MattyPersil/Nyx_bot.git
```
- Run
```bash
git pull
```
- to verify if this is working correctly
# Create rust project
- enter git project
```bash
cd /Nyx_bot/
```
- Initialize rust project with cargo
```bash
cargo init
```
# Start a bot for the first time 
- go into main.rs (in src directory)
- Preferably with an good ide for rust (visual studio code/ rustrover(what i'm working on))
- I personnally cloned the repository on my personnal work machine, and then push it and pull it on the vm before compiling on the vm
