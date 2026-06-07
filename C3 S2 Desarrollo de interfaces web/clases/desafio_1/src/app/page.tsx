"use client";

import {useState} from "react";
import styles from "./page.module.css";
import {Cocktail} from "@/types/Cocktail";
import {getCocktailByName} from "@/lib/api/cocktail";
import Link from "next/link";


export default () =>
{
    const [query, setQuery] = useState("");
    const [resultados, setResultados] = useState<Cocktail[] | null>(null);
    const [loading, setLoading] = useState(false);

    const buscar = async () =>
    {
        setLoading(true);
        const drinks = await getCocktailByName(query);
        setResultados(drinks);
        setLoading(false);
    };

    return (
        <div className={styles.page}>
            <input
                value={query}
                onChange={(e) => setQuery(e.target.value)}
                placeholder="Nombre del cocktail"
            />

            <button onClick={buscar}>Buscar</button>

            {loading && <p>Cargando…</p>}

            {resultados && (
                <ul>
                    {resultados.map((c) => (
                        <li key={c.idDrink}>
                            <Link href={`/cocktail/${c.idDrink}`}>
                                {
                                    c.strDrink
                                    }
                                <img src={c.strDrinkThumb} alt={c.strDrink} width={100}/>
                            </Link>
                        </li>
                    ))}
                </ul>
            )}

            {resultados === null && !loading && <p>Sin resultados</p>}
        </div>
    );
}