type Marca =
    {
        id: Number
        , nombre: String
    };

type Prenda =
    {
        id: Number
        , nombre: String
        , marca: Marca
    };

const marca1:Marca = {id:1,nombre:"A"};
const marca2:Marca = {id:2,nombre:"B"};
const marca3:Marca = {id:3,nombre:"C"};
const marca4:Marca = {id:4,nombre:"D"};

const prenda1:Prenda = {id:1,nombre:"prenda1", marca:marca2};
const prenda2:Prenda = {id:3,nombre:"prenda2", marca:marca3};
const prenda3:Prenda = {id:4,nombre:"prenda3", marca:marca3};
const prenda4:Prenda = {id:5,nombre:"prenda3", marca:marca4};

const arrayDePrendas:Array<Prenda> = [prenda1, prenda2, prenda3, prenda4]
const arrayDeMarcas:Array<Marca> = arrayDePrendas.map((x)=>x.marca)
console.log(arrayDeMarcas);