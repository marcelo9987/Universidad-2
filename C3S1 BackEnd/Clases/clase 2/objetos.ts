type Carro =
    {
        id: number;
        name: string;
        plate: string;
        cc: number;
    };

let xj40: Carro =
    {
        id: 7049,
        name: "ingrid",
        plate: "485161K",
        cc: 3200,
    }

type Persona =
    {
        name: string;
        lastName: String;
        age: number;
        gender?: boolean;
    };
let persona1: Persona =
    {
        name: "Antonio",
        lastName: "Figueras",
        age: 22,
        gender: false,
    }
let persona2: Persona =
    {
        name: "Juan",
        lastName : "Fernandez",
        age: 27,
    }
let persona3: Persona =
    {
        name: "Maria",
        lastName : "Salcedo",
        age: 30,
        gender: true,
    }
let persona4: Persona =
    {
        name: "Uxía",
        lastName : "López",
        age: 22,
    }

const array_de_personas: Array<Persona> = [persona1, persona2, persona3, persona4]
console.log(array_de_personas)

