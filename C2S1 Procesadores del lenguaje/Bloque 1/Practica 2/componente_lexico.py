class ComponenteLexico:
    """ ComponenteLexico

    Clase que contiene un lexema y su correspondiente etiqueta.
    """
    def __init__(self, etiqueta, valor=""):
        """ Constructor

        :param etiqueta: Etiqueta asociada al token a crear
        :param valor: valor asociado al token.
        """
        self.etiqueta = etiqueta
        self.valor = valor

    def get_etiqueta(self):
        return self.etiqueta

    def __str__(self):
        """
        Se utiliza cuando se hace un print de un elemento cuyo tipo sea el de la clase (ComponenteLexicoBasico)

        :return: etiqueta y (si existe) valor.
        """
        if len(self.valor) == 0:
            return f"<{self.etiqueta}>"
        else:
            return f"<{self.etiqueta}, {self.valor}>"
