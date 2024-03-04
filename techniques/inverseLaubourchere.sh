inverseLabourchere(){
    money=$1
    technique=$2
    jg_malas_consec=""
    menu
    while true; do
        apuesta=$((${secuencia[0]} + ${secuencia[-1]}))
        money=$(($money-$apuesta))
        dinero_maximo "$money" "$dinero_mx"
        resume "$money" "$dinero_mx" "$jg_totales" "$jg_buenas" "$jg_malas" "$jg_malas_consec"
        let jg_totales+=1
        random_number=$(($RANDOM % 37))
        is_par_impar "$random_number" "$option";codigo_respuesta=$?
        if [ "$codigo_respuesta" -eq 0 ]; then
            let jg_buenas+=1
            jg_malas_consec=" "
            reward=$(($apuesta*2))
            secuencia+=($apuesta)
            money=$(($money+$reward))
        else
            let jg_malas+=1
            jg_malas_consec=" $random_number "
            secuencia=("${secuencia[@]:1:${#secuencia[@]}-2}")
            if [ "${#secuencia[@]}" -le 1 ]; then 
                secuencia=($valores)
            fi
        fi
    done
}
