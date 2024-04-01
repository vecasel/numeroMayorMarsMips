.data
prompt: .asciiz "Ingrese un número: "
prompt2: .asciiz "Ingrese la cantidad de números a comparar: "
message: .asciiz "\nEl número más grande es: "

.text
.globl main

main:
    # Solicitar al usuario la cantidad de números a comparar
    li $v0, 4
    la $a0, prompt2
    syscall

    # Leer la cantidad de números
    li $v0, 5
    syscall
    move $t0, $v0  # Almacenar la cantidad en $t0

    # Inicializar variables para comparación
    li $t1, 0  # Mayor número
    li $t2, 0  # Número actual

    # Bucle para leer los números
    loop:
        beq $t0, $zero, done  # Salir si ya se han leído suficientes números

        # Solicitar al usuario ingresar un número
        li $v0, 4
        la $a0, prompt
        syscall

        # Leer el número ingresado
        li $v0, 5
        syscall
        move $t2, $v0

        # Comparar con el mayor número actual
        bgt $t2, $t1, update_max

        # Si no es mayor, continuar con el siguiente número
        j next_number

    update_max:
        move $t1, $t2  # Actualizar el mayor número

    next_number:
        sub $t0, $t0, 1  # Decrementar la cantidad restante
        j loop

    done:
        # Mostrar el mayor número
        li $v0, 4
        la $a0, message
        syscall

        li $v0, 1
        move $a0, $t1
        syscall

        # Salir del programa
        li $v0, 10
        syscall
