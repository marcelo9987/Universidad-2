import axios from "axios";

const getCharacter =  async(id:number) =>
    {
       const personaje = await axios.get("https://rickandmortyapi.com/api/character/"+id);
       return personaje.data;
    };

const getCharacterTheRightWay = async (id:number) =>
    {
        try
            {
                const respuesta = await axios.get("https://rickandmortyapi.com/api/character/"+id);
                return respuesta.data;
            }
        catch (err)
            {
                if(axios.isAxiosError(err))
                    {
                        console.log("Axios error:" + err.message);
                    }
                else
                    {
                        console.log("Error:" + err);
                    }
            }
    };



// Varias promesas

const getCharacters = async (ids: number[]) =>
    {
        ids.forEach(async (x)=>
            {
                console.log(await getCharacter(x));
            });
    };

// getCharacters([1,2,3])

const getMultipleCharacters = async (ids:number[]) =>
    {
        const promesas = ids.map(elem=>
        {
            const arrayDePromesas = axios.get("https://rickandmortyapi.com/api/character/"+elem);
            return arrayDePromesas;
        });
        const respuesta =await Promise.all(promesas);
        console.log(respuesta)
    };

getMultipleCharacters([4,5,9])
