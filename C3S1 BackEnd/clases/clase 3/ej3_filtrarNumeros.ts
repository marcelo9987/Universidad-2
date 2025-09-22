const arrayDeNumeros: Array<number> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 66, 50, 4, 78, 16, 21, 15, 99]

const multiplos_2_5: Array<number> = arrayDeNumeros.filter((x) =>
    {
        if ((x % 2 === 0) && (x % 5 === 0))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
)

const multiplos_2_5_find: number|undefined = arrayDeNumeros.find((x) =>
    {
        if ((x % 2 === 0) && (x % 5 === 0))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
)

const multiplos_2_5_some: boolean = arrayDeNumeros.some((x) =>
    {
        if ((x % 2 === 0) && (x % 5 === 0))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
)

const multiplos_2_5_every: boolean = arrayDeNumeros.every((x) =>
    {
        if ((x % 2 === 0) && (x % 5 === 0))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
)

console.log(multiplos_2_5);
console.log(multiplos_2_5_find);
console.log(multiplos_2_5_some);
console.log(multiplos_2_5_every);

