import {api} from "@/lib/api/axios";
import {FachadaPokemon, PokemonCompleto, PokemonNombreImagen} from "@/types/Pokemon";

type RespuestaBusqueda =
    {
        count: number;
        next: string;
        previous: string;
        results: Array<FachadaPokemon>;

    };

export const todosLosPokemons = async (pagina:number) =>
{
    return (await api.get<RespuestaBusqueda>(`/pokemon/?offset=${pagina*50}&limit=50`)).data.results;
};

export const obtenerPokemonsConImagen = async (pagina:number) =>
{
    const pokemons: Array<FachadaPokemon> = await todosLosPokemons(pagina);
    const pokemonsCompletos: Array<PokemonNombreImagen> = await Promise.all(pokemons.map(async (elemento) =>
    {

        const pokemonCompleto = await pokemonEspecifico(elemento.name);

        return {
            id:pokemonCompleto.id,
            name: elemento.name,
            image: pokemonCompleto.sprites.front_default
        } as PokemonNombreImagen;
    }));
    return pokemonsCompletos;
};

export const pokemonEspecifico = async (pokemon: string) =>
{
    return (await api.get<PokemonCompleto>(`/pokemon/${pokemon}`)).data;
};
