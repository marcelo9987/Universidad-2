import axios from "axios";


type Personaje =
    {
        id: number,
        name: string,
        status: string,
        species: string,
        type: string,
        gender: string,
        origin: any,
        location: any,
        image: string,
        episode: Array<string>,
        url: string,
        created: string
    };


const obtenerPersonajes = (name?: string, status?: string, gender?: string): void =>
    {
        let url: string = "https://rickandmortyapi.com/api/character/?";
        let esPrimero: boolean = true;
        if (name != undefined)
            {
                url += `name=${name}`;
                esPrimero = false;
            }
        if (status != undefined)
            {
                if (!esPrimero)
                    {
                        url += `&status=${status}`;
                    } else
                    {
                        url += `status=${status}`;
                        esPrimero = false;
                    }
            }
        if (gender != undefined)
            {
                if (!esPrimero)
                    {
                        url += `&gender=${gender}`;
                    } else
                    {
                        url += `gender=${gender}`;
                    }
            }

        axios.get(url).then
        (
            (response) =>
            {
                const personajes: Personaje[] = response.data.results.map((e: Personaje) =>
                    (
                        {
                            id: e.id,
                            name: e.name,
                            status: e.status,
                            species: e.species,
                            type: e.type,
                            gender: e.gender,
                            origin: e.origin,
                            location: e.location,
                            image: e.image,
                            episode: e.episode,
                            url: e.url,
                            created: e.created

                        }));
                console.log(personajes);
                return personajes;
            });

    }

obtenerPersonajes("rick", "alive");

/*axios.get("https://rickandmortyapi.com/api/character/43,4,2").then
(
   (response) =>
   {
       const personajes: Personaje[] = response.data.map((e:Personaje) =>
           (
               {
                   id: e.id,
                   name: e.name,
                   status: e.status,
                   species: e.species,
                   type: e.type,
                   gender: e.gender,
                   origin: e.origin,
                   location: e.location,
                   image: e.image,
                   episode: e.episode,
                   url: e.url,
                   created: e.created

               }));
       console.log(personajes);
   });*/




