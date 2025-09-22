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

const buscarMarca = (prenda:Prenda):Marca=>
    {
        return prenda.marca
    };

    const r:Marca = {id:1, nombre:"jhuh"};
    const p:Prenda = {id:2, nombre:"jhuh", marca:r};

    console.log(buscarMarca(p));