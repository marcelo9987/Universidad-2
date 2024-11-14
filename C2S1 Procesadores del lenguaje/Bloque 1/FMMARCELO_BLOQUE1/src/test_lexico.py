from lexico import Lexico

def main():
    programa = open("prueba2.c").read() #= '''float k;\nfor (int i=0; i<=10; i=i+1)\n\tk=k*2.3;'''


    #archivo = open("prueba2.c")
    lexico = Lexico(programa)

    print(f"Test lexico basico \t{programa}\n")

    c = 0
    while True:
        etiqueta_lexica = lexico.get_componente_lexico()
        print(etiqueta_lexica)

        c += 1
        if etiqueta_lexica.get_etiqueta() == "end_program":
            break

    print(f"\n Componentes lexicos: {c}, lineas: {lexico.get_lineas()}")


if __name__ == "__main__":
    main()
