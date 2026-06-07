"use client";
import styles from "./page.module.css";
import {obtenerPokemonsConImagen, todosLosPokemons} from "@/lib/api/pokemon";
import {useEffect, useState} from "react";
import {PokemonNombreImagen} from "@/types/Pokemon";
import {PokeCard} from "@/components/PokemonCard";

export default function Home()
{
    const [pokemons, setPokemons] = useState<Array<PokemonNombreImagen>>([]);
    const [cargando, setCargando] = useState<boolean>(true);
    const [pagina, setPagina] = useState<number>(0)

    const sumarPagina = () =>
    {
        setPagina(pagina+1);
    }

    useEffect(() =>
    {
        obtenerPokemonsConImagen(pagina).then((resultado) =>
            {
                setPokemons(resultado);
            }
        ).catch(() =>
            {
            }
        ).finally(() =>
        {
            console.log("hola");
            console.log(pokemons);
            setCargando(false);
        });
    }, [pagina]);

    return (
        <div className={styles.page}>
            {cargando && <p>cargando...</p>}

            {!cargando && <button onClick={sumarPagina}>Siguiente página</button>}
            {!cargando &&
                <ul>
                    {pokemons.map((e:PokemonNombreImagen) =>
                        (
                            <PokeCard pokemon={e} key={e.id}></PokeCard>
                        ))
                    }
                </ul>
            }

        </div>
    );
}
