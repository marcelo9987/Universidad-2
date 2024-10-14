from componente_lexico import ComponenteLexico
from lexico import Lexico

'''
LA GRAMÁTICA Y EL ESQUEMA DE TRADUCCIÓN:

expresion   → expresion + term   { print('+') } |
              expresion - term   { print('-') } |
              term

term        → term * factor      { print('*') } |
              term / factor      { print('/') } |
              factor

factor      → ( expresion )      |
              num                { print(num.val) }

Para eliminar la recursión por la izquierda se usan las reglas:

    A -> A alpha |               ===>      A' -> beta A'
         beta                              A' -> alpha A' |
                                                 epsilon
'''

class TraductorExpresionPostfijo:
    def __init__(self, lexico):
        self.lexico = lexico
        self.componente_lexico = self.lexico.get_componente_lexico()
        self.pila = []
        self.postfijo_str = ""

    def postfijo(self):
        self.expresion() #Inicio de la gramatica
        self.postfijo_str = " ".join(self.pila) #Devuelvo el resultado

        return str(self.postfijo_str)

    # Expresiones a completar -> Borra el pass y rellena la función
    def expresion(self):
        pass

    def factor(self):
        pass

    def termino(self):
        pass

    def mas_terminos(self):
        pass

    def mas_factores(self):
        pass

    '''
    La función `compara` es fundamental en el análisis sintáctico.
    Su función principal es asegurarse de que el componente léxico actual
    coincida con el token esperado en la gramática. Si coinciden, la función
    avanza al siguiente token. Si no coinciden, se produce un **error de sintaxis**,
    lo que indica que la estructura del programa no sigue las reglas de la gramática
    del lenguaje.
    '''
    def compara(self, etiqueta_lexica):
        if self.componente_lexico.etiqueta == etiqueta_lexica:
            self.componente_lexico = self.lexico.get_componente_lexico()
        else:
            raise SyntaxError(f"ERROR: Se esperaba {etiqueta_lexica}")
        

    '''
    Función para calcular el valor total de la expresión
    '''
    def calculate(self):
        pila_valor = []
        tokens = self.postfijo_str.strip().split()

        if len(tokens) > 0:
            for token in tokens:
                if self.es_numerico(token):
                    pila_valor.append(int(token))
                else:
                    num2 = pila_valor.pop()
                    num1 = pila_valor.pop()
                    if token == "+":
                        pila_valor.append(num1 + num2)
                    elif token == "-":
                        pila_valor.append(num1 - num2)
                    elif token == "*":
                        pila_valor.append(num1 * num2)
                    elif token == "/":
                        if num2 != 0:
                            pila_valor.append(num1 // num2)  # División entera
                        else:
                            raise ZeroDivisionError("ERROR: División por cero.")
                    else:
                        raise ValueError(f"ERROR: Operador desconocido {token}")

            return pila_valor.pop()
        return "Is empty :("

    def es_numerico(self, str):
        try:
            int(str)
            return True
        except ValueError:
            return False
