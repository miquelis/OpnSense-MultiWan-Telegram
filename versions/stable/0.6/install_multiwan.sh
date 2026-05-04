#!/bin/sh

# 1. Definir variáveis
REPO_URL="https://github.com/andrelcmadeira/OpnSense-MultiWan-Telegram.git"
TEMP_DIR="/tmp/multiwan_git"
DEST_DIR="/usr/local/opnsense/scripts/monit"

echo "### Iniciando instalação do Gateway MultiWAN Telegram ###"

# 2. Instalar dependências (Git) caso não existam
echo "-> Verificando dependências..."
pkg install -y git

# 3. Clonar o repositório
echo "-> Clonando repositório..."
rm -rf $TEMP_DIR
git clone $REPO_URL $TEMP_DIR

# 4. Mover os arquivos para o local correto
echo "-> Instalando scripts em $DEST_DIR..."
PATH_GIT="versions/stable/0.6"
cp $TEMP_DIR/$PATH_GIT/gateway_multiwan $DEST_DIR/
cp $TEMP_DIR/$PATH_GIT/sendTelegram.sh $DEST_DIR/

# 5. Dar permissão de execução
chmod +x $DEST_DIR/gateway_multiwan
chmod +x $DEST_DIR/sendTelegram.sh

# 6. Limpeza
rm -rf $TEMP_DIR

echo "### Instalação concluída! ###"
echo "Lembre-se de editar os scripts em $DEST_DIR/sendTelegram.sh para configurar seu TOKEN e ID do Telegram."
