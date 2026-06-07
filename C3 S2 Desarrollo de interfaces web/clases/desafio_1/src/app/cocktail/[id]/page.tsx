"use client";

import {getCocktailById} from "@/lib/api/cocktail";
import {Cocktail} from "@/types/Cocktail";
import {useParams} from "next/navigation";
import {useState} from "react";

const cocktailEspecifico =  () =>
{
    const [cocktail, setCocktail] = useState<Cocktail | null>(null);

    const {id} = useParams();
    getCocktailById(id).then((e) =>
    {
        setCocktail(e);
    });

    if (!cocktail)
    {
        return <p>No hay cocktail :(</p>;
    }

    return (
        <div>
            <h1>{cocktail.strDrink}</h1>
            <img src={cocktail.strDrinkThumb} alt={cocktail.strDrink}/>
            <p>{cocktail.strInstructions}</p>
        </div>
    );
};
export default cocktailEspecifico;