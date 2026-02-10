// Operacion.ts
const Operacion = {
    SUMA: 1,
    RESTA: 2,
    DIVISION: 3,
    MULTIPLICACION: 4
};

type Operacion = (typeof Operacion)[keyof typeof Operacion];

export type { Operacion };
export const { SUMA, RESTA, DIVISION, MULTIPLICACION } = Operacion;
