"use client";

import {useParams} from "next/navigation";
import {useEffect, useState} from "react";
import {PokemonCompleto} from "@/types/Pokemon";
import {pokemonEspecifico} from "@/lib/api/pokemon";
import Link from "next/link";

const PaginaPokemonEspecifico = () =>
{
    const params = useParams();
    const [pokemon, setPokemon] = useState<PokemonCompleto | null>(null);
    if (!params.name || params.name.length === 0)
    {
        return (
            <main className="pais-page">
                <h1>¡¡ERROR!!: País no especificado</h1>
            </main>
        );
    }

    useEffect(() =>
    {


        pokemonEspecifico(params.name as string).then((p) =>
        {
            setPokemon(p);
        });
    }, []);

    return (
        <main>
            {pokemon &&
                <div>
                    <header>
                        <h1>{pokemon.name}</h1>
                    </header>

                    <br/>
                    <br/>

                    <section>
                        {pokemon.sprites?.front_default && <img src={pokemon.sprites?.front_default}/>}
                        <p>Altura:{ pokemon.height}</p>
                        <p>Especie:{pokemon.species.name}</p>
                        <p>Juegos:  {Object.values
                                           (pokemon.game_indices
                                                   .map((e)=>(e.version.name)))
                                         .join(",")}
                        </p>
                    </section>

                    <Link href={"/"}>
                        <button>Volver</button>
                    </Link>
                </div>
            }
        </main>
    );


};

export default PaginaPokemonEspecifico;
