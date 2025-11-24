import {IResolvers} from "@graphql-tools/utils";

type Coche =
    {
        id: string
        , name: string
        , brand: string
        , plate: string
    }

const carros: Array<Coche> = [
    {
        id: '1'
        , name: 'Model S'
        , brand: 'Tesla'
        , plate: 'ABC123'
    },
    {
        id: '2'
        , name: 'Mustang'
        , brand: 'Ford'
        , plate: 'XYZ789'
    },
];


export const resolvers: IResolvers =
    {
        Query:
            {
                getCoches: () => carros,
                getCoche: (_, {id}) => carros.find(coche => coche.id === id)
            },
        Mutation:
            {
                addCoche: (_, {
                    name,
                    brand,
                    plate
                }) =>
                {
                    const newCoche: Coche =
                        {
                            id: String(carros.length + 1),
                            name:name,
                            brand:brand,
                            plate:plate
                        };
                    carros.push(newCoche);
                    return carros.find(coche => coche.id === String(carros.length));
                }
            }
    };
