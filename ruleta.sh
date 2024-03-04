#!/bin/bash

source utils.sh

TECHNIQUES_DIR=techniques
for file in "$TECHNIQUES_DIR"/*.sh; do
    source "$file"
done

main(){
    while getopts 'm:t:h' args; do
        case $args in 
            m) money=$OPTARG;;
            t) technique=$OPTARG;;
            h) help_panel;;
            *) help_panel;;
        esac
    done
    if [ "$money" ] && [ "$technique" ]; then
        if [ "$technique" == "martingala" ]; then
            martingala "$money"
        elif [ "$technique" == "inverselabourchere" ]; then
            inverseLabourchere "$money" "$technique"
        elif [ "$technique" == "inversemartingala" ]; then
            inverseMartingala "$money"
        elif [ "$technique" == "fibonacci" ]; then
            fibonacci "$money" 
        elif [ "$technique" == "dalembert" ]; then
            dAlembert "$money"
        else
            echo -e "\n${COLOR_RED}[*]${COLOR_RESET} ${COLOR_RED}No contamos con esa tecnica aun...${COLOR_RESET} \n"
        fi
    else
        echo -e "\n${COLOR_RED}[*]${COLOR_RESET} ${COLOR_RED}Debes ingresar todos los parametros${COLOR_RESET}\n"
        exit 1
    fi
}
main "$@"
