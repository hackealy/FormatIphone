#!/bin/bash

# Verifica se a biblioteca libimobiledevice está instalada
if ! [ -x "$(command -v ideviceinstaller)" ]; then
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

# Formata o dispositivo iOS
ideviceinstaller -U com.apple.mobilephone

# Verifica se a formatação foi bem-sucedida
if [ $? -eq 0 ]; then
  echo "O dispositivo iOS foi formatado com sucesso."
else
  echo "Erro: não foi possível formatar o dispositivo iOS. Tente novamente."
  exit 1
fi

exit 0
