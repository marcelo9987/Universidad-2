"use client";
import {useEffect, useState} from "react";
import {getPaises, getPaisesPorNombre} from "@/lib/api/paises";
import "./page.css";
import {Country} from "@/types/Country";
import {CountryCard} from "@/components/CountryCard/CountryCard";


const Home = () =>
{
    const [paises, setPaises] = useState<Array<Country>>([]);
    const [entrada, setEntrada] = useState<string>("");

    const [cargando, setCargando] = useState<boolean>(true);
    const [error, setError] = useState<boolean>(false);

    const [buscar, setBuscar] = useState<number>(0);

    const botonPulsado = () =>
    {
        setBuscar((prev) => prev + 1);
    };

    const buscarTodos = async () =>
    {
        setPaises(await getPaises());
    };

    const buscarPaises = async () =>
    {
        setPaises(await getPaisesPorNombre(entrada));
    };

    useEffect(() =>
    {

        setCargando(true);
        setError(false);

        const fetch = entrada.trim() ? buscarPaises : buscarTodos;
        fetch().catch((e) =>
        {
            console.error("Error al buscar países:", e);
            setError(true);
        }).finally(() =>
        {
            setCargando(false);
        });
    }, [buscar]);


    return (

        <div>
            <div className={"titulo"}>
                <h1>Países del mundo</h1>
            </div>


            <div className={"contenedor-paises"}>
                <div className={"entrada-paises"}>
                    <input
                        value={entrada}
                        onChange={(e) => setEntrada(e.target.value)}
                        onKeyDown={(e) =>
                        {
                            if (e.key === "Enter")
                            {
                                botonPulsado();
                            }
                        }
                        }
                        placeholder="País a buscar"
                    />
                    <button
                        onClick={botonPulsado}
                    >Buscar
                    </button>
                </div>

                <div className={"lista-paises"}>
                    {cargando &&
                        <p>Cargando países...</p>
                    }

                    {
                        error &&
                        <p>Error al cargar países. Por favor, inténtalo de nuevo más tarde.</p>
                    }

                    {!cargando && !error &&
                        (
                            <ol>
                                {[...paises]
                                    .sort((a, b) => a.cca3.localeCompare(b.cca3))
                                    .map((paisEspecifico: Country) =>
                                        (
                                            <CountryCard
                                                key={paisEspecifico.cca3}

                                                pais={
                                                    {
                                                        name: paisEspecifico.name.common,
                                                        flag: paisEspecifico.flag,
                                                    }
                                                }
                                            />
                                        ))}
                            </ol>
                        )
                    }
                </div>
            </div>
        </div>

    )
        ;
};

export default Home;
