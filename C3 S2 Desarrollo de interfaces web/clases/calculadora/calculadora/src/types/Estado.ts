// Estado.ts
const Estado = {
    INTRODUCIENDO: 0
    , OPERACION_MARCADA: 1
    , MOSTRAR_RESULTADO: 2
};

type Estado = (typeof Estado)[keyof typeof Estado];

export type {Estado};
export const { INTRODUCIENDO, OPERACION_MARCADA, MOSTRAR_RESULTADO } = Estado;
