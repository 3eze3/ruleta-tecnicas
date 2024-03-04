martingala() {
    money=$1
    menu
    jg_malas_consec=""
    while true; do
        money=$(($money - $apuesta))
        dinero_maximo "$money" "$dinero_mx"
        resume "$money" "$dinero_mx" "$jg_totales" "$jg_buenas" "$jg_malas" "$jg_malas_consec" 
        let jg_totales+=1
        random_number=$(($RANDOM % 37))
        is_par_impar "$random_number" "$option";codigo_respuesta=$?
        if [ "$codigo_respuesta" -eq 0 ]; then
            reward=$(($apuesta * 2))
            money=$(($money+$reward))
            apuesta=$current_apuesta
            let jg_buenas+=1
            jg_malas_consec=" "
        else
            jg_malas_consec+=" $random_number "
            let jg_malas+=1
            apuesta=$(($apuesta * 2))
        fi
    done
}

