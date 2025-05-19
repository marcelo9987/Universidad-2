from types import NoneType


def imprimir_metadatos(meta) -> None:
    """
    Imprime la meta en un formato legible.

    :param meta: La meta a imprimir.
    """
    print("\033[92m{:<45} \033[94m{:<80}".format("Nombre", "Valor"))
    for clave, valor in meta.items():
        # Si es  una lista, la convertimos a string
        if isinstance(valor, list):
            valor = ", ".join(map(str, valor))
        # Si es un diccionario, lo convertimos a string
        elif isinstance(valor, dict):
            valor = "".join(f"\n\t \033[96m{k}: '\033[94m'{v}" for k, v in valor.items())
        elif isinstance(valor, NoneType):
            valor = "N/A"

        print("\033[92m{:<45} \033[94m{:<80}".format(clave, valor))
