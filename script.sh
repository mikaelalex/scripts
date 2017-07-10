#!/bin/bash

menu (){
echo "-------------------------------------------------------------------------------"
echo "         BEM VINDO(A), Gostaria de realizar qual das seguintes operações?     "
echo "-------------------------------------------------------------------------------"
echo "[ 1 ] Renomear pastas/arquivos em um servidor remoto."
echo "[ 2 ] Renomear pastas/arquivos na máquina local"
echo "[ 3 ] Sair"
echo -n "Resposta: ";read resp
case $resp in
	1) remote;;
	2) rename;;
	3) exit 0;;
	*) echo "Opção inválida"; menu;;
esac
}

remote () {
echo -n "Digite o IP do servidor: "; read ip
echo -n "Digite o nome do usuário: "; read user
echo -n "Qual porta deseja conectar: : " ;read port
	ssh $user@$ip -p $port && rename

}


rename() {
echo "========================================="
echo "Este script irá renomear todos os arquivos e pastas
que estão abaixo do diretório informado, substituindo espaços
em branco por underscore e removendo acentos.Digite o CAMINHO
ABSOLUTO do diretório ou . para ser feito no diretório atual: (`pwd`):"
echo -n "Diretório:" ; read dir
echo "========================================="



count=`ls -lR |grep "./" | wc -l | cut -d" " -f2`;
echo "Existem $count pastas abaixo deste diretóio.!"

while [ $count -gt 0 ]
do
	find $dir -name "*" -exec rename -v 's/\ /_/','s/ç/c/','s/Ç/C/','s/á/a/','s/é/e/','s/í/i/','s/ó/o/','s/ú/u/','s/Á/A/','s/É/    E/','s/Í/I/','s/Ó/O/','s/Ú/U/' '{}' \;
	if [ $count -le 0 ]; then
	exit 0
	fi
	count=`expr $count - 1`
done
}
menu
