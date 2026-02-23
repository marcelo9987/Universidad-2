'use client';

import {useParams} from "next/navigation";
import {Character} from "@/types";
import {useEffect, useState} from "react";
import {getCharacterById} from "@/lib/api/character";
import {AxiosError} from "axios";

const estaRecibeId = () =>
{

    const {id} = useParams();

    const [personaje, setPersonaje] = useState<Character | null>(null);
    const [error, setError] = useState<string>("");
    const [loading, setLoading] = useState<boolean>(true);

    useEffect(() =>
    {
        getCharacterById(Number(id)).then((res) =>
        {
            setPersonaje(res);
        }).catch((err:AxiosError) =>
        {
            setError(err.message);
        }).finally(() =>
        {
            setLoading(false);
        });
    }, [id]);

    return (
        <div>
            <h1>Recibiendo el id: {id}</h1>
            {
                !personaje && loading && <p>Cargando...</p>
            }
            {
                error && <h2>{error}</h2>
            }
            {personaje &&
                (<>
                    <img src={personaje.image} alt={personaje.name}/>
                    <h2>{personaje.name}</h2>
                </>)
            }
        </div>
    );
};

export default estaRecibeId;