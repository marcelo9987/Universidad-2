const listaNumerosAleatorios: number[] = Array.from({length: 150}, () =>
{
    return Math.floor(Math.random() * 26)
})

const soloNumerosPares = (x: number[]): number[] =>
{
    return x.filter(numero => numero % 2 == 0);
}

const soloNumerosPares2 = (x: number[]): number[] =>
{
    return x.filter((numero) =>
    {
        if (numero % 2 == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    });
}

//Antes de la función
console.log(listaNumerosAleatorios);
console.log(listaNumerosAleatorios.every((n)=>{return n % 2 == 0}));

// Tras pasar la función
console.log(soloNumerosPares2(listaNumerosAleatorios));
console.log(soloNumerosPares2(listaNumerosAleatorios).every((n)=>{return n % 2 == 0}));

listaNumerosAleatorios.forEach((n)=>{if(n%2==0){console.log(n)}})
listaNumerosAleatorios.forEach((n)=>{console.log((n%2==0)?n:null)})

const multiCinco = listaNumerosAleatorios.filter((n)=> (n%5==0 && n!=0))
console.log(multiCinco)