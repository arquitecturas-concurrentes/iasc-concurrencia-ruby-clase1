## Consideraciones

### Instalar RVM

```
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

```
\curl -sSL https://get.rvm.io | bash
```


### Que pasa si al instalar ruby 2.3.6 falla

si tenemos un error de este tipo....

```bash
Installing requirements for ubuntu.
Updating system..ernesto password required for 'apt-get --quiet --yes update': 
......
Installing required packages: libssl1.0-dev....
Error running 'requirements_debian_libs_install libssl1.0-dev',
please read /home/ernesto/.rvm/log/1586275824_ruby-2.3.6/package_install_libssl1.0-dev.log
Requirements installation failed with status: 100.
```

habra que instalar openssl aparte

```ruby
rvm pkg install openssl
rvm install 2.3.6 --with-openssl-dir=$HOME/.rvm/usr
```