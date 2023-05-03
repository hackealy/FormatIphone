#!/bin/bash

# Verifica se a biblioteca libimobiledevice está instalada
if ! [ -x "$(command -v idevicerestore)" ]; then
  echo "Erro: libimobiledevice não está instalada. Instale-a antes de continuar."
  exit 1
fi

# Verifica se o dispositivo iOS está conectado
device=$(idevice_id -l)
if [ -z "$device" ]; then
  echo "Erro: dispositivo iOS não está conectado. Conecte-o e tente novamente."
  exit 1
fi

# Desbloqueia o dispositivo iOS
idevicepair pair

# Pede ao usuário o caminho para o arquivo IPSW
read -p "Insira o caminho para o arquivo IPSW: " ipsw_path

# Verifica se o arquivo IPSW existe
if [ ! -f "$ipsw_path" ]; then
  echo "Erro: o arquivo IPSW não foi encontrado no caminho especificado. Tente novamente."
  exit 1
fi

# Reinstala o firmware do dispositivo iOS
idevicerestore -e "$ipsw_path"

# Verifica se a reinstalação foi bem-sucedida
if [ $? -eq 0 ]; then
  echo "O firmware do dispositivo iOS foi reinstalado com sucesso."
else
  echo "Erro: não foi possível reinstalar o firmware do dispositivo iOS. Tente novamente."
  exit 1
fi

exit 0
