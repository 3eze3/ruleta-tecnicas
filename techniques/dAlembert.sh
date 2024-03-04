dAlembert() {
    money=$1
    current_apuesta=$2
    menu
    jg_malas_consec=""
    while true; do 
        dinero_maximo "$money" "$dinero_mx"
        resume "$money" "$dinero_mx" "$jg_totales" "$jg_buenas" "$jg_malas" "$jg_malas_consec"
        let jg_totales+=1
        random_number=$((RANDOM % 37))
        is_par_impar "$random_number" "$option"
        codigo_respuesta=$?
        if [ "$codigo_respuesta" -eq 0 ]; then 
            let jg_buenas+=1
            jg_malas_consec=" "
            money=$((money + current_apuesta))
        else
            let jg_malas+=1
            jg_malas_consec=" $random_number "
            money=$((money - current_apuesta))
            if [ "$current_apuesta" -gt 1 ]; then
                current_apuesta=$((current_apuesta - 1))
            else
                current_apuesta=$((current_apuesta + 1))
            fi
        fi
    done
}

