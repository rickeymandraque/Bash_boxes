#!/bin/bash

# coloration du texte
RED='\033[38;5;160m' #ex echo -e "${RED} ALERT"
NC='\033[0m'    #ex echo -e "${NC} Normal"
GREEN='\033[38;1;32m'   #ex echo -e "${GREEN} OK"
YELLOW='\033[38;5;226m' #ex echo -e "${YELLOW} Warning"

#fonction d'aide standard pour illustration
function show_usage() {
	printf "Usage: $0 \"url\" \n"
	printf "\n"
	printf " Options:\n\n"
	printf "  -h | --help \t\t Voir l'aide\n\n"

	return 0
}
if [[ $1 == "--help"   ]] || [[ $1 == "-h"   ]]; then
	show_usage
elif  [ -z "$1" ]; then
	printf ""${RED}"Erreur"${NC}" url manquante\n"
	show_usage
else

	# mise en boite
	# je ne comprend pas cette partie et je ne sais pas comment l'adaptée
	function box_out() {
		local s=("$@") b w
		for l in "${s[@]}"; do
			((w < ${#l})) && {
				b="$l"
				w="${#l}"
			}
		done
		# j'ai compris que tput setaf était pour la coloration, mais je ne sais pas l'adapté en fonction du résultat.
		tput setaf 3
		# je ne comprend pas comment àjouter des "=" en foction des tab, cela se base sur le nombre de caracteres.
		# j'aimerai que tout soit centré dans la boite/ le cadre
		echo -e "\t=${b//?/=}=
\t|| ${b//?/ } \t||"
		for l in "${s[@]}"; do
			printf '\t||\t %s%*s%s \t||\n' "$(tput setaf 4)" "-$w" "$l" "$(tput setaf 3)"
		done
		echo -e "\t|| ${b//?/ } \t||
 \t=${b//?/=}="
		tput sgr 0
	}
	# script qui ne sert pas à grand chose, juste pour illustration

	if curl --output /dev/null --silent --head --fail "$1"; then
		URL_EXIST="L'url est joingnable"
		IP_HOSTNAME="$(dig +short "$1")"
		Color="${GREEN}"
	else
		URL_EXIST="L'url est injoignable"
		IP_HOSTNAME="Pas d'ip de disponible"
		Color="${RED}"
	fi
	echo "voici le style que je souhaite"
	printf "\n\t=================================================\n"
	printf "\t||\t\t      Détails du site: \t\t||\n"
	printf "\t||\t   Adresse du site: "${YELLOW}""$1""${NC}"\t||\n"
	printf "\t||\t   État du site: "$Color"$URL_EXIST"${NC}"\t||\n"
	printf "\t||\t   Adresse IP du site: "$Color"$IP_HOSTNAME"${NC}"\t||\n"
	printf "\t===================================================\n"
	printf "\n"
	echo "voici ce que cela donne, il manque les couleurs, le centrage et  une partie du cadre"
	box_out "Détails du site:" "Adresse du site: "${YELLOW}""$1""${NC}"" "État du site: "$Color"$URL_EXIST"${NC}"" "Adresse IP du site: "$Color"$IP_HOSTNAME"${NC}""

	box_out "ceci" "est un exemple" "sur plusieurs lignes" "mais ce n'est pas" "centré correctement" "il manque des bords"
fi
