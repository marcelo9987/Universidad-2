"use client"

import {useParams} from "next/navigation";
import {useState} from "react";
import {PokemonCompleto} from "@/types/Pokemon";
import {pokemonEspecifico} from "@/lib/api/pokemon";

const PaginaPokemonEspecifico =  () =>
{
    const params = useParams();
    const [pokemon, setPokemon] = useState<PokemonCompleto | null>(null);
    if (!params.name || params.name.length === 0) {
        return (
            <main className="pais-page">
                <h1>¡¡ERROR!!: País no especificado</h1>
            </main>
        );
    }


    pokemonEspecifico(params.name as string).then((p) =>
    {
        setPokemon(p);
    });

    return (
        <div>
            {pokemon &&
                pokemon.name}
        </div>
    )


}

export default PaginaPokemonEspecifico;
