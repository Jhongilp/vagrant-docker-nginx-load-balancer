echo "Desinstalar versiones anteriores de Docker ..."
sudo apt-get remove docker docker-engine docker.io containerd runc

echo "Actualizando librerías de Ubuntu ..."
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

echo "Agregando la clave GPG oficial de Docker"
# GPG es usado para cifrar y firmar digitalmente. GPG utiliza criptografía de clave pública para que los usuarios puedan comunicarse de un modo seguro
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Agregar un repositorio stable
echo "Descargando repositorio de Docker ..."
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo "Actualizando el paquete apt e instalando la última versión de Docker Engine"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io