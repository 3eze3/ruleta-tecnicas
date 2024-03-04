fibonacci(){
    local money=$1
    menu
    local jg_malas_consec=""
    local fibonacci_sequence=(1 1)
    local fibonacci_index=2
    
    while true; do
        money=$((money - apuesta))
        dinero_maximo "$money" "$dinero_mx"
        resume "$money" "$dinero_mx" "$jg_totales" "$jg_buenas" "$jg_buenas_consec" "$jg_malas" "$jg_malas_consec"
        ((jg_totales++))
        local random_number=$((RANDOM % 37))
        is_par_impar "$random_number" "$option"
        local codigo_respuesta=$?

        if [ "$codigo_respuesta" -eq 0 ]; then
            ((jg_buenas++))
            jg_malas_consec=" "
            local reward=$((apuesta * 2))
            money=$((money + reward))
        else
            ((jg_malas++))
            jg_malas_consec=" $random_number "
            if [ "${#fibonacci_sequence[@]}" -gt "$fibonacci_index" ]; then
                ((fibonacci_index++))
            fi
            apuesta=${fibonacci_sequence[$((fibonacci_index - 1))]}
            ((fibonacci_index++))
            local next_fibonacci=$((fibonacci_sequence[$((fibonacci_index - 2))] + fibonacci_sequence[$((fibonacci_index - 3))]))
            fibonacci_sequence+=($next_fibonacci)
            apuesta=${fibonacci_sequence[$((fibonacci_index - 1))]}  # Actualizar la apuesta
        fi
    done
}

