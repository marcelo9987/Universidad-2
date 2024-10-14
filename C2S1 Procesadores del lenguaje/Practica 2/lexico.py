from componente_lexico import ComponenteLexico

class Lexico:
    def __init__(self, programa): #constructor
        self.posicion = 0 #posición del caracter actual [a analizar]
        self.lineas = 1 #lineas totales del programa
        '''palabras_reservadas almacena el lexema (clave) y el token (valor) correspondiente ese lexema
           la etiqueta del token coincide con el lexema de la palabra reservada'''
        self.palabras_reservadas = { #tipo de dato: diccionario. Equivalente a hashtable en Java
            "break": "break",
            "do": "do",
            "else": "else",
            "float": "float",
            "for": "for",
            "if": "if",
            "int": "int",
            "while": "while"
        }

        '''
        Al final del programa se añade el carácter # para poder detectar el final.
        Cuando el analizador léxico encuentra este carácter, devuelve el token “end_program”.
        '''
        self.programa = programa + "#"

    '''
    con esta función, vamos avanzando sobre la cadena del programa, 
    seleccionando el caracter que nos toca analizar
    '''
    def extrae_caracter(self):
        caracter = self.programa[self.posicion]
        self.posicion += 1
        return caracter

    def devuelve_caracter(self):
        self.posicion -= 1

    '''
    FUNCIÓN QUE SE ENCARGA DEL ANÁLISIS
    '''
    def get_componente_lexico(self):
        while True: #un compilador itera siempre.
            self.caracter = self.extrae_caracter() #Lo primero, es coger un caracter.

            '''
            aquí comprobamos todo lo que no es un caracter a analizar. Espacios, saltos de linea..."
            '''
            if self.caracter == '#':
                return ComponenteLexico("end_program")

            if self.caracter in [' ','\t', '\r', '\n']:
                if self.caracter in ['\r','\n']:
                    if self.caracter == '\r' and self.extrae_caracter()!='\n':
                        self.devuelve_caracter()
                        continue
                    self.lineas += 1   
                continue
            else:
                break

        # secuencias de letras - identificadores o palabras reservadas
        if self.caracter.isalpha():
            lexema = self.caracter
            self.caracter = self.extrae_caracter()
            while self.caracter.isalnum(): #un identificador puede tener numeros, menos en la primera letra
                lexema += self.caracter
                self.caracter = self.extrae_caracter()
            self.devuelve_caracter()

            if lexema in self.palabras_reservadas:
                return ComponenteLexico(self.palabras_reservadas[lexema])
            else:
                return ComponenteLexico("id", lexema)
        
        # secuencias de digitos, numero enteros o reales
        elif self.caracter.isdigit(): #numero=lexema
            numero = ""

            # Recoge los dígitos del número entero
            while self.caracter.isdigit():
                numero += self.caracter
                self.caracter = self.extrae_caracter()

            # Si no es un punto decimal, devolvemos un entero
            if self.caracter != '.':
                self.devuelve_caracter()
                return ComponenteLexico("int", numero)

            # Si es un punto decimal, recogemos los dígitos siguientes
            numero += self.caracter
            self.caracter = self.extrae_caracter()

            while self.caracter.isdigit():
                numero += self.caracter
                self.caracter = self.extrae_caracter()

            self.devuelve_caracter()
            return ComponenteLexico("float", numero)
        
        else:
            '''operadores aritméticos, relacionales, lógicos y
            caracteres delimitadores'''
            if self.caracter == '=':
                if self.extrae_caracter()== '=':
                    return ComponenteLexico("equals",
                                            self.caracter+'=')
                self.devuelve_caracter()
                return ComponenteLexico("assignment", self.caracter )
            elif self.caracter == '<':
                if self.extrae_caracter()=='=':
                    return ComponenteLexico("less_equals",self.caracter+'=')
                self.devuelve_caracter()
                return ComponenteLexico("less_than", self.caracter )
            elif self.caracter == '>':
                if self.extrae_caracter()=='=':
                    return ComponenteLexico("greater_equals",self.caracter+'=')
                self.devuelve_caracter()
                return ComponenteLexico("greater_than", self.caracter)
            elif self.caracter == '!':
                return ComponenteLexico("not", self.caracter)
            elif self.caracter == '+':
                return ComponenteLexico("add", self.caracter)
            elif self.caracter == '-':
                return ComponenteLexico("subtract", self.caracter)
            elif self.caracter == '*':
                return ComponenteLexico("multiply", self.caracter)
            elif self.caracter == '/':
                return ComponenteLexico("divide", self.caracter)
            elif self.caracter == '%':
                return ComponenteLexico("remainder", self.caracter)
            elif self.caracter == ';':
                return ComponenteLexico("semicolon")
            elif self.caracter == '(':
                return ComponenteLexico("open_parenthesis")
            elif self.caracter == ')':
                return ComponenteLexico("closed_parenthesis")
            elif self.caracter == '{':
                return ComponenteLexico("open_bracket")
            elif self.caracter == '}':
                return ComponenteLexico("closed_bracket")
            elif self.caracter == '&':
                return ComponenteLexico("bitwise_and", self.caracter)
            elif self.caracter == '&&':
                return ComponenteLexico("and", self.caracter)
            elif self.caracter == '|':
                return ComponenteLexico("or", self.caracter)
            elif self.caracter == '[':
                return ComponenteLexico("open_square_brackets")
            elif self.caracter == ']':
                return ComponenteLexico("closed_square_brackets")
            else:
                return ComponenteLexico("invalid_char")

    def get_lineas(self):
        return self.lineas
