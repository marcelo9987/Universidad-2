const arrayDeNumeros:Array<number> =[2,5,10,66,50,4,78,16,5,21,15,99]

const multiplos_2_5:Array<number> = arrayDeNumeros.filter((x)=>(((x%2==0) && (x%5==0))))
console.log(multiplos_2_5);