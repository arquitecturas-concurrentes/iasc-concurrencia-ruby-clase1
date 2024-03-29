## Consideraciones

### Instalar RVM

```bash
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

```bash
\curl -sSL https://get.rvm.io | bash
```

#### Que pasa si recibo un error?

Puede ser que existan errores cada tanto de certificado cuando se usan los servidores principales (`hkp://pool.sks-keyservers.net`)

```bash
gpg: keyserver receive failed: Server indicated a failure
```

Para remediarlo basta con usar otro `keyserver`:

```bash
gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

## Instalar Ruby 2.3.6

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

o

```ruby
rvm install 2.3.6 --autolibs=disable
```

o....

ruby 2.3.5 tambien puede usarse...

```ruby
rvm install 2.3.5 --autolibs=disable
```

## Instalar Ruby 3.1.1

```ruby
rvm install 3.1.1
```

## Instalar el ultimo Jruby

```ruby
rvm install jruby
```

### Alternativa (Docker)

Teniendo instalado docker localmente, o siguiendo la siguiente [docker](https://docs.docker.com/engine/install/), se puede bajar la imagen de docker de esta clase que contiene ya instalado las versiones utilizadas en clase junto con el codigo:


```bash
docker run --name iasc-clase1-ruby -it ghcr.io/arquitecturas-concurrentes/iasc-concurrencia-tradicional-ruby:1.0.0
```

una vez dentro del contenedor, vamos a poder usar rvm para cambiar de versiones

```bash
root@0e31b9f7da22:/app# rvm list
   jruby-9.2.20.0 [ x86_64 ]
   ruby-2.3.6 [ x86_64 ]
=> ruby-2.7.5 [ x86_64 ]
 * ruby-3.0.0 [ x86_64 ]

# => - current
# =* - current && default
#  * - default

root@0e31b9f7da22:/app# 
```