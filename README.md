# dotfiles

[个人常用软件](https://shenmian.github.io/notes/%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F/%E4%B8%AA%E4%BA%BA%E5%B8%B8%E7%94%A8%E8%BD%AF%E4%BB%B6/)

## Arch Linux

```sh
sudo pacman -S ansible
```

```sh
ansible-galaxy install -r requirements.yml
ansible-playbook -K setup.yml
```

## Windows

```ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
./setup.ps1
```
