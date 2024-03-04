# Funciones para el manejo de colores en la salida del terminal
readonly COLOR_RESET='\033[0m' # Resetear color
readonly COLOR_BLACK='\033[1;37m' # Respuestas finales
readonly COLOR_RED='\033[0;31m' # Errores/Fallos
readonly COLOR_GREEN='\033[0;32m' # Buenas Jugadas
readonly COLOR_YELLOW='\033[0;33m' # DineroMaximoGanado
readonly COLOR_PURPLE='\033[0;35m'
readonly COLOR_CYAN='\033[0;36m' # Texo general

# Colores de fondo
readonly BACKGROUND_CYAN='\033[0;46m'
readonly BACKGROUND_BLACK='\033[0;40m'


ctr_c(){
    echo -e "\n\n[*] Saliendo...\n\n"
    exit 1
}

trap ctr_c INT


help_panel(){
    echo -e "\n\n${COLOR_YELLOW}[*]${COLOR_RESET} ${COLOR_BLACK}Uso del script: <$0> <argumentos> ${COLOR_RESET}\n"
    echo -e "\n${COLOR_YELLOW}[*]${COLOR_RESET} ${COLOR_BLACK}-m: Ingresar el dinero inicial para la simulacion${COLOR_RESET}\n"
    echo -e "\n${COLOR_YELLOW}[*]${COLOR_RESET} ${COLOR_BLACK}-t: Tecnicas para la simulacion: \n\t -> martingala \n\t -> inverselaubourchere \n\t -> inversemartingala \n\t -> fibonacci \n\t -> dalembert>${COLOR_RESET}\n"
    echo -e "${COLOR_YELLOW}[*]${COLOR_RESET} ${COLOR_CYAN} Recuerda el valor de apuesta no puede ser mas que tu dinero actual..${COLOR_RESET}\n\n"
    exit 1
}

# Estoy tomando como metodo privados

resume(){
    money=$1
    dinero_maximo=$2
    jg_totales=$3
    jg_buenas=$4
    jg_malas=$5
    jg_malas_consec=$6
    if [ "$money" -lt 0 ]; then
        echo -e "\n\n${BACKGROUND_CYAN}-------------------------------------------------------${COLOR_RESET}"
        echo -e "\n${COLOR_YELLOW}[*]${COLOR_RESET} ${COLOR_BLACK}Dinero insuficiente... $money$ ${COLOR_RESET}\n"
        echo -e "\n${COLOR_YELLOW}[*]${COLOR_RESET} ${COLOR_BLACK}Resumen Juego:\n${COLOR_RESET}"
        echo -e "\t${COLOR_CYAN}[->]${COLOR_RESET} ${COLOR_BLACK}Jugadas totales: $jg_totales${COLOR_RESET}"
        echo -e "\t${COLOR_CYAN}[->]${COLOR_RESET} ${COLOR_BLACK}Dinero maximo alcanzado es: $dinero_mx$ ${COLOR_RESET}"
        echo -e "\t${COLOR_CYAN}[->]${COLOR_RESET} ${COLOR_BLACK}Jugadas Buenas totales: $jg_buenas${COLOR_RESET}"
        echo -e "\t${COLOR_CYAN}[->]${COLOR_RESET} ${COLOR_BLACK}Jugadas Malas totales: $jg_malas${COLOR_RESET}"
        echo -e "\t${COLOR_CYAN}[->]${COLOR_RESET} ${COLOR_BLACK}Jugadas Malas Consecutivas: $jg_malas_consec${COLOR_RESET} \n"
        echo -e "\n\n${BACKGROUND_CYAN}-------------------------------------------------------${COLOR_RESET}"
        exit 1
    fi
}


dinero_maximo(){
    money=$1
    dinero_mx=$2 
    if [ "$dinero_mx" -le "$money" ];then 
       dinero_mx=$money 
    fi
}


is_par_impar(){
    random_number=$1
    option=$2
    if [ "$(($random_number % 2))" -eq 0 ] && [ "$option" == "par" ] && [ "$random_number" -ne 0 ]; then
        return 0
    elif [ "$(($random_number % 2))" -ne 0 ] && [ "$option" == "impar" ]; then
        return 0
    else
        return 1
    fi
}


valid_option(){
    option=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    # Ternaria 
    [ "$option" != "par" ] && [ "$option" != "impar" ] && return 1 || return 0
}

valid_valor(){
    money_v=$1
    apuesta_v=$2
    # Ternaria 
    [ "$money_v" -le 0 ] || [ "$apuesta_v" -le 0 ] || [ "$apuesta_v" -gt "$money_v" ] && return 1 || return 0
}

menu() {
    echo -e "\n${COLOR_YELLOW}[*]${COLOR_RESET} ${COLOR_BLACK}Ruleta:${COLOR_RESET} \n"
    echo -e "\t${COLOR_CYAN}[-->]${COLOR_RESET} ${COLOR_BLACK}PAR${COLOR_RESET} "
    echo -e "\t${COLOR_CYAN}[-->]${COLOR_RESET} ${COLOR_BLACK}IMPAR${COLOR_RESET} \n"
    read -p "Ingresar tu apuesta [Par/impar]: " apuesta_option
    if [ "$technique"  == "inverselabourchere" ];then
        read -p "Ingresar la secuencia de tu apuesta (Separado por espacios): " valores 
        secuencia=($valores)
        if [ "${#secuencia[@]}" -eq 0 ] || [ "${#secuencia[@]}" -eq 1 ];then
            echo -e "\n${COLOR_YELLOW}[*]${COLOR_RESET} ${COLOR_BLACK} Para esta tecnica por lo menos 2 numeros en tu secuencia\n${COLOR_RESET}"
            exit 1
        fi
        apuesta_valor=$((${secuencia[0]}+${secuencia[-1]}))
    else
        read -p "Ingresar el valor de tu apuesta: " apuesta_valor
    fi
    option=$apuesta_option
    apuesta=$apuesta_valor
    valid_option "$option";codigo_option=$?
    valid_valor "$money" "$apuesta";codigo_apuesta=$?
    if [ "$codigo_option" -eq 1 ] || [ "$codigo_apuesta" -eq 1 ]; then 
        echo -e "\n${BACKGROUND_BLACK}                                                ${COLOR_RESET}"
        echo -e "${COLOR_RED}\n[*]${COLOR_RESET} ${COLOR_RED}Ingresar opciones validas${COLOR_RESET}\n"
        echo -e "${BACKGROUND_BLACK}                                                ${COLOR_RESET}"
        sleep 0.1
        help_panel
        exit 1
    fi
    current_apuesta=$apuesta
    jg_totales=0
    jg_malas=0
    jg_buenas=0
    dinero_mx=$money
}

