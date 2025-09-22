const listaDePalabras: String[] = ["Queso", "Mermelada", "Manzanas"];


const palabrasEncadenadas = listaDePalabras.reduce((acumulador, valorActual) =>
{
    if (valorActual === "")
        {
            return acumulador;
        }
    return acumulador + " ; " + valorActual;
})

console.log(palabrasEncadenadas);