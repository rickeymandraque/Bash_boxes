#!/bin/bash

# scrit non fonctionnel et buggé


RED='\033[38;5;160m'        #ex echo -e "${RED} ALERT"
NC='\033[0m'                #ex echo -e "${NC} Normal"
GREEN='\033[38;1;32m'       #ex echo -e "${GREEN} OK"
ORANGE='\033[38;0;33m'      #ex echo -e "${ORANGE} AVERTISSEMENT"
YELLOW='\033[38;5;226m'     #ex echo -e "${YELLOW} Warning"

function box_out() {
	local s=("$@") b w
	for l in "${s[@]}"; do
		((w < ${#l})) && {
			b="$l"
			w="${#l}"
		}
	done
	tput setaf 3
	# inscrit des "||===||" pour le cadre du haut
	echo -e "\t =${b//?/=}=
\t || ${b//?/ }\t\t||"
	for l in "${s[@]}"; do
		printf '\t ||\t %s%*s%s \t||\n' "$(tput setaf 4)" "-$w" "$l" "$(tput setaf 3)"
	done

	# inscrit des "||===||" pour le cadre du bas
	echo -e "\t || ${b//?/ }\t\t||
 \t =${b//?/=}="
	tput sgr 0
}

# Fonction pour centrer le texte
function centre_test() {

	function get_width() {
		echo "$(wc -L <<<"$1")"
	}

	function multi_space() {
		num=$1
		if [ $num -le 0 ]; then
			echo ""
			return
		fi
		v=$(printf "%-${num}s" " ")
		echo "$v"
	}

	columns="$(tput cols)"

	for line in "$@"; do
		width=$(get_width "$line")
		left_padding=$(((columns - width) / 2))
		if [ $left_padding -lt 0 ]; then
			left_padding=0
		fi
		spaces=$(multi_space "$left_padding")
		printf "%s%s\n" "$spaces" "$line"
	done
}

messagetest=$(box_out "ceci" "est un exemple" "sur plusieurs lignes" "mais ce n'est pas" "centré correctement" "il manque des bords"

centre_test $messagetest
