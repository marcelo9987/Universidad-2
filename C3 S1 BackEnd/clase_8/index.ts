import axios from "axios"

type Episode = {
    id: number;
    name: string;
    air_date: string;
    episode: string;
    characters: string[];
    url: string;
    created: string;
};

type Character = {
    id: number;
    name: string;
    status: 'Alive' | 'Dead' | 'unknown';
    species: string;
    type: string;
    gender: 'Female' | 'Male' | 'Genderless' | 'unknown';
    origin: {
        name: string;
        url: string;
    };
    location: {
        name: string;
        url: string;
    };
    image: string;
    episode: string[];
    url: string;
    created: string;
};


const getEpisodesFromCharacter = async (id: number) =>
    {
        const personaje:Character = (await axios.get("https://rickandmortyapi.com/api/character/" + id)).data;
        // const episodios:Episode[] = await Promise.all(
        try
            {

                const episodios: Array<Episode> = await Promise.all(personaje.episode.map(async (ep: string) =>
                    {
                        return (await axios.get(ep)).data;
                    })
                )
                return episodios;
            }
        catch (err)
            {
                console.log("Error:" + err)
                return null;
            }


    };
console.log(await getEpisodesFromCharacter(2));