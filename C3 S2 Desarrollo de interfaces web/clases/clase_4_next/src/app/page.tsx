'use client';

import Link from "next/link";
import {useRouter} from "next/navigation";

const Home = () =>
{
    const router = useRouter();
    return (
        <div>
            <h1>Hola Mundo</h1>
            <Link href="/patata">¿Patata?</Link>
            <br/>
            <button onClick={() =>
            {
                router.push("/patata");
            }}> Te lleva a patata con lógica
            </button>
        </div>
    );
};

export default Home;
