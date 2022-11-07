# Balanceador de carga usando Nginx
Esta práctica consiste en la creación de un cluster de servidores web y un balanceador de carga.
Para esto se crearán 3 máquinas virtuales, dos de las cuales correrán el cluster que servirá 
una página web. La tercera máquina correrá Nginx como balanceador de carga.

![Load balancer diagram!](/diagram.png "Nginx load balancer")

# Requisitos
Para poder reproducir este repositorio es necesario tener instalado VirtualBox y Vagrant. 

# Obtener archivos de configuración inicial

```
git clone https://github.com/Jhongilp/vagrant-docker-nginx-load-balancer.git
cd .\vagrant-docker-nginx-load-balancer\
```

## Creación de máquinas virtuales
El archivo Vagranfile contiene el script necesario para crear y levantar las 3 maquinas virtuales

```
vagrant up
```

## Provisionamiento de las máquinas virtuales
Las máquinas tendrán un script de provisionamiento que ejecutarán los siguientes pasos: 
### Instalación de Docker

```
# Desinstalar versiones anteriores de Docker
sudo apt-get remove docker docker-engine docker.io containerd runc
# Actualizar librerías de Ubuntu
sudo apt-get update
# 
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Agregue la clave GPG oficial de Docker
# GPG es usado para cifrar y firmar digitalmente. GPG utiliza criptografía de clave pública para que los usuarios puedan comunicarse de un modo seguro
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Agregar un repositorio stable
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Actualice el paquete apt e instale la última versión de Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# check if Docker is running
sudo systemctl status docker
sudo docker run hello-world
```

### Configuración cliente en las máquinas VM1 Y VM2
El cliente consiste en una aplicación web llamada Logex, la cual está creada usando React.
Todo el código necesario está contenerizado en una imagen Docker llamadas jhongilp/logex-client 

Correr dos instancias del cliente en la máquina VM1
```
sudo docker run -d -p 3000:3000 jhongilp/logex-client
sudo docker run -d -p 3001:3000 jhongilp/logex-client
```

Correr dos instancias del cliente en la máquina VM2
```
sudo docker run -d -p 3000:3000 jhongilp/logex-client
sudo docker run -d -p 3001:3000 jhongilp/logex-client
```

### Instalación de Nginx en la máquina VM3
```
git clone https://github.com/Jhongilp/vm3.git
cd ./vm3/
sudo docker build -t nginx-balancer .
sudo docker run -p 80:80 nginx-balancer
```

### Pruebas
Cada petición deberá hacerse usando la url 192.168.100.5
Cada vez que se envíe una petición al balanceador de carga, éste se encargará de redirigir la
petición a uno de los servidores del clúster.

![Logex web app!](/web-app.png "Logex web app")

# Artillery
Realizar las pruebas de rendimiento del servidor desde la máquina anfitrión

```
npm install -g artillery
artillery run load-balancer-test.yml
```