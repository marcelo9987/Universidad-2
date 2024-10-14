from traductor_postfijo import TraductorExpresionPostfijo
from lexico import Lexico

def main():
    # Traducción
    expresion = "(25 * (2 + 2)) / 2 * 3"
    
    # Suponiendo que `Lexico` y `TraductorExpresionPostfijo` ya están implementados
    expr = TraductorExpresionPostfijo(Lexico(expresion))


    print(f"\n\nLa expresión: {expresion} en notación postfija es: {expr.postfijo()} "
          f"y su valor es: {expr.calculate()}")

    # Análisis Léxico
    programa = "(25*(2+2))/2*3"
    lexico = Lexico(programa)
    
    print(f"\nTest léxico básico\t{programa}\n")
    
    etiqueta_lexica = lexico.get_componente_lexico()
    
    while etiqueta_lexica.etiqueta != "end_program":
        print(etiqueta_lexica)
        etiqueta_lexica = lexico.get_componente_lexico()

# Ejecución del test
if __name__ == "__main__":
    main()
