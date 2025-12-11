type Cliente = {
    seccion: string, nombre: string
};

type tipoClientes = {
    alimentacion: Cliente[], farmacia: Cliente[]
};

const cliente1: Cliente = {seccion: "farmacia", nombre: "f1"};
const cliente2: Cliente = {seccion: "alimentacion", nombre: "a1"};
const cliente3: Cliente = {seccion: "farmacia", nombre: "f2"};
const cliente4: Cliente = {seccion: "alimentacion", nombre: "a2"};
const cliente5: Cliente = {seccion: "farmacia", nombre: "f3"};
const cliente6: Cliente = {seccion: "alimentacion", nombre: "a3"};
const cliente7: Cliente = {seccion: "farmacia", nombre: "f4"};
const cliente8: Cliente = {seccion: "alimentacion", nombre: "a4"};
const cliente9: Cliente = {seccion: "farmacia", nombre: "f5"};
const cliente10: Cliente = {seccion: "alimentacion", nombre: "a5"};


const clientes: Array<Cliente> = [cliente1, cliente2, cliente3, cliente4, cliente5, cliente6, cliente7, cliente8, cliente9, cliente10];

const valorInicial: tipoClientes = {
    alimentacion: []
    , farmacia: []
}

const clientesFiltrados = clientes.reduce<tipoClientes>((acumulador, valorActual) =>
{
    if (valorActual.seccion === "alimentacion")
        {
            return {
                alimentacion: [...acumulador.alimentacion, valorActual]
                , farmacia: acumulador.farmacia
            }
        } else
        {
            return{
                alimentacion:acumulador.alimentacion,
                farmacia: [...acumulador.farmacia, valorActual]

            }
        }
},  valorInicial)

console.log(clientesFiltrados)
