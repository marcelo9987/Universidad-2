// Reduce

const numeritos: number[] = [1,2,3];

const valorInicial = 0;

const sumaDesdeInicial = numeritos.reduce((accumulator,valorActual)=>
    {
        return accumulator + valorActual;
    }, valorInicial
)

console.log(sumaDesdeInicial);