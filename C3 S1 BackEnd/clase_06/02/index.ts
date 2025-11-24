import axios from "axios";

const getMultipleCharacterName = async (ids:number[]) =>
{
    const promesas = ids.map( async (elem)=>
    {
        const arrayDePromesas = (await axios.get('https://rickandmortyapi.com/api/character/'+elem)).data.name;
        return arrayDePromesas;
    });
    const respuesta =await Promise.all(promesas);
    return respuesta
};

const getMultipleCharacterNameSafe = async (ids:number[]) =>
    {
        const promesas = ids.map( async (elem)=>
        {
            const arrayDePromesas = (await axios.get(`https://rickandmortyapi.com/api/character/${elem}`)).data.name;
            return arrayDePromesas;
        });
        const respuesta =await Promise.allSettled(promesas);
        respuesta.forEach((elem) =>
        {
            if(elem.status==="fulfilled")
            {
                console.log(elem.value);
            }
            else
            {
                console.log(elem.status,"Error");
            }
        });
    };

// console.log(await getMultipleCharacterName([1,2,3]))
getMultipleCharacterNameSafe([1,2,3]);