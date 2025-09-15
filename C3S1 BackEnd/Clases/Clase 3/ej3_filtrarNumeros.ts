const arrayDeNumeros: Array<number> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 66, 50, 4, 78, 16, 21, 15, 99]

const multiplos_2_5: Array<numberw> = arrayDeNumeros.filter((x) =>
    {
        return ((x % 2 == 0) && (x % 5 == 0));
    }
)

console.log(multiplos_2_5);