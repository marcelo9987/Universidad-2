import "./PokemonCard.css"
import Link from "next/link";
import {PokemonNombreImagen} from "@/types/Pokemon";

export const PokeCard = (pokemon:{pokemon: PokemonNombreImagen}) =>
{

    const pokemonUsado= pokemon.pokemon;
    return (
            <Link href={`/pokemon/${pokemonUsado.name}`}>
                <article className={"pokemonCard"}>
                    {pokemonUsado.name}
                    <img src={pokemonUsado.image} />

                </article>
            </Link>
    )
}