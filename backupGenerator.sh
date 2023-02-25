#!/bin/bash

DIRDESTINO=$HOME/Backup

if [ ! -d $DIRDESTINO ]
then
	echo "Criando Diretório $DIRDESTINO..."
	mkdir -p $DIRDESTINO
fi

DIAS7=$(find $DIRDESTINO -ctime -7 -name backup_home\*tgz)

if [ "$DIAS7" ] 
then
	echo "Já foi gerado um backup do diretório $HOME nos últimos 7 dias."
	echo -n "Deseja continuar? (N/s): "
	read -n1 CONT
	if [ "$CONT" = N -o "$CONT" = n -o "$CONT" = "" ]
	then 
		echo "Backup Abortado!"
		exit 1
	elif [ $CONT = S -o $CONT = s]
	then echo "Será criado mais um backup para a mesma semana"
	else
		echo "Opção Inválida"
		exit 2
	fi
fi

echo "Criando Backup..."
ARQ="backup_home_$(date +%Y%m%d%H%M).tgz"
tar zcvpf $DIRDESTINO/ARQ --absolute-names --exclude="$HOME/Google Drive" --exclude=$HOME/Videos --exclude="$DIRDESTINO" "$HOME"/* > /dev/null

echo
echo "O backup \""$ARQ"\" foi criado em $DIRDESTINO"
echo
echo "Backup Concluído!"
