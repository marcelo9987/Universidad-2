// App.tsx
import {useState} from 'react';

import './App.css';
import {DIVISION, MULTIPLICACION, type Operacion, RESTA, SUMA} from "./types/Operacion.ts";
import {type Estado, INTRODUCIENDO, MOSTRAR_RESULTADO, OPERACION_MARCADA} from "./types/Estado.ts";


const App = () =>
{


    const [display, setDisplay] = useState<string>("");
    const [memoria, setMemoria] = useState<number | null>(null);
    const [operacion, setOperacion] = useState<Operacion | null>(null);
    const [estado, setEstado] = useState<Estado>(INTRODUCIENDO);


    const anhadirNumero = (numeroNuevo: number) =>
    {
        if (estado === MOSTRAR_RESULTADO)
        {
            setDisplay(numeroNuevo.toString());
            setEstado(INTRODUCIENDO);
            return;
        }
        setDisplay(display + numeroNuevo.toString());
    };

    const establecerOperacion = (operacionNueva: Operacion) =>
    {
        setOperacion(operacionNueva);
        setEstado(OPERACION_MARCADA);
        setMemoria(parseInt(display));
        setDisplay("");
    };

    return (
        <div className={"MegaPanel"}>
            <div>
                <div>
                    <input type="text" id="title" name="title"
                           value={display}
                           readOnly/><br/><br/>
                </div>
                <div className={"teclado"}>
                    <div className="numeros">
                        <div className="fila">
                            <button onClick={() => anhadirNumero(1)}>1</button>
                            <button onClick={() => anhadirNumero(2)}>2</button>
                            <button onClick={() => anhadirNumero(3)}>3</button>
                        </div>
                        <div className="fila">
                            <button onClick={() => anhadirNumero(4)}>4</button>
                            <button onClick={() => anhadirNumero(5)}>5</button>
                            <button onClick={() => anhadirNumero(6)}>6</button>
                        </div>
                        <div className="fila">
                            <button onClick={() => anhadirNumero(7)}>7</button>
                            <button onClick={() => anhadirNumero(8)}>8</button>
                            <button onClick={() => anhadirNumero(9)}>9</button>
                        </div>
                    </div>
                    <div className={"panelNumeros"}>
                        <button onClick={() =>
                        {
                            establecerOperacion(SUMA);
                        }}>+
                        </button>
                        <button onClick={() =>
                        {
                            establecerOperacion(RESTA);
                        }}> -
                        </button>
                        <button onClick={() =>
                        {
                            establecerOperacion(DIVISION);
                        }}>/
                        </button>
                        <button onClick={() =>
                        {
                            establecerOperacion(MULTIPLICACION);
                        }}>*
                        </button>


                        <button onClick={() =>
                        {

                            if (memoria === null || estado !== OPERACION_MARCADA)
                            {
                                return;
                            }
                            setEstado(MOSTRAR_RESULTADO);

                            const numeroDisplay: number = parseInt(display);

                            switch (operacion)
                            {
                                case SUMA:
                                    setDisplay((memoria + numeroDisplay).toString());
                                    break;
                                case RESTA:
                                    setDisplay((memoria - numeroDisplay).toString());
                                    break;
                                case MULTIPLICACION:
                                    setDisplay((memoria * numeroDisplay).toString());
                                    break;
                                case DIVISION:
                                    setDisplay((memoria / numeroDisplay).toString());
                                    break;
                            }

                            setMemoria(null);
                            setOperacion(null);
                        }
                        }> =
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default App;
