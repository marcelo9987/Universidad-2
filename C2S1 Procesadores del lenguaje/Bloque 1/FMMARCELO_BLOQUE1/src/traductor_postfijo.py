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
    """
    Clase que implementa un traductor de expresiones aritméticas a notación postfija.
    """

    def __init__(self, lexico):
        self.lexico = lexico
        self.componente_lexico = self.lexico.get_componente_lexico()
        self.pila = []
        self.postfijo_str = ""

    def postfijo(self):
        """
        Traduce una expresión aritmética (en notación infija) a notación postfija.
        """
        self.expresion()  # Inicio de la gramatica
        self.postfijo_str = " ".join(self.pila)  # Devuelvo el resultado
        return str(self.postfijo_str)

    def expresion(self):
        self.termino()
        self.mas_terminos()

    def factor(self):
        if self.componente_lexico.valor == '(':
            self.compara("open_parenthesis")
            self.expresion()
            self.compara("closed_parenthesis")
        elif self.componente_lexico.etiqueta == "int":
            self.pila.append(self.componente_lexico.valor)
            self.compara("int")
        elif self.componente_lexico.etiqueta == "float":
            self.pila.append(self.componente_lexico.valor)
            self.compara("float")

    def termino(self):
        self.factor()
        self.mas_factores()

    #TODO: Se puede hacer secuencialmente con un while mezclando las condiciones de los ifs.
    # Lo suyo sería hacer un análisis de tiempos y ver
    # si es más eficiente hacerlo de una forma u otra (aunque yo apostaría por la versión secuencial).
    def mas_terminos(self):
        if self.componente_lexico.valor == '+':
            self.compara("add")
            self.termino()
            self.pila.append("+")
            self.mas_terminos()
        elif self.componente_lexico.valor == '-':
            self.compara("subtract")
            self.termino()
            self.pila.append("-")
            self.mas_terminos()
    # TODO: same que en mas_terminos
    def mas_factores(self):
        if self.componente_lexico.valor == '*':
            self.compara("multiply")
            self.factor()
            self.pila.append("*")
            self.mas_factores()
        elif self.componente_lexico.valor == '/':
            self.compara("divide")
            self.factor()
            self.pila.append("/")
            self.mas_factores()

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
        """
            Calcula el valor total de la expresión
            :return: El valor total de la expresión
        """
        pila_valor = []
        tokens = self.postfijo_str.strip().split()

        if len(tokens) > 0:
            for token in tokens:
                if self.es_entero(token):
                    pila_valor.append(int(token))
                elif self.es_flotante(token):
                    pila_valor.append(float(token))
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
                            pila_valor.append(num1 / num2)  # División entera
                        else:
                            raise ZeroDivisionError(f"ERROR: División por cero: ¿has intentado dividir {num1} entre {num2} (aka 0)?.")
                    else:
                        raise ValueError(f"ERROR: Operador desconocido {token}")

            return pila_valor.pop()
        return "Is empty :("


    def es_entero(self, _str):
        """
        Comprueba si una cadena es un número entero
        :param _str: Cadena a comprobar
        :return: True si es un número, False en caso contrario
        """
        try:
            int(_str)
            return True
        except ValueError:
            return False

    # Esta función me habilita para procesar números flotantes
    def es_flotante(self, _str):
        """
        Comprueba si una cadena es un número flotante
        :param _str: Cadena a comprobar
        :return: True si es un número, False en caso contrario
        """
        try:
            float(_str)
            return True
        except ValueError:
            return False
