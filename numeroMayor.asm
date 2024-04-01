.data
prompt: .asciiz "Ingrese un n�mero: "
prompt2: .asciiz "Ingrese la cantidad de n�meros a comparar: "
message: .asciiz "\nEl n�mero m�s grande es: "

.text
.globl main

main:
    # Solicitar al usuario la cantidad de n�meros a comparar
    li $v0, 4
    la $a0, prompt2
    syscall

    # Leer la cantidad de n�meros
    li $v0, 5
    syscall
    move $t0, $v0  # Almacenar la cantidad en $t0

    # Inicializar variables para comparaci�n
    li $t1, 0  # Mayor n�mero
    li $t2, 0  # N�mero actual

    # Bucle para leer los n�meros
    loop:
        beq $t0, $zero, done  # Salir si ya se han le�do suficientes n�meros

        # Solicitar al usuario ingresar un n�mero
        li $v0, 4
        la $a0, prompt
        syscall

        # Leer el n�mero ingresado
        li $v0, 5
        syscall
        move $t2, $v0

        # Comparar con el mayor n�mero actual
        bgt $t2, $t1, update_max

        # Si no es mayor, continuar con el siguiente n�mero
        j next_number

    update_max:
        move $t1, $t2  # Actualizar el mayor n�mero

    next_number:
        sub $t0, $t0, 1  # Decrementar la cantidad restante
        j loop

    done:
        # Mostrar el mayor n�mero
        li $v0, 4
        la $a0, message
        syscall

        li $v0, 1
        move $a0, $t1
        syscall

        # Salir del programa
        li $v0, 10
        syscall
