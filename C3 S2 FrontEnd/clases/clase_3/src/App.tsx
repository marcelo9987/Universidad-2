import {useEffect, useState} from 'react';
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
import {api} from "./api/api.ts";

const App = () =>
{

    const [palabrita, setPalabrita] = useState<string>("");

    const [count, setCount] = useState<number>(0);

    useEffect(() =>
    {
        api.get("/character").then((response) =>
        {
            console.log
                   (response.data);
        });
    },[count]);

    return(
        <>
            <p>
                {count}
            </p>
            <p>
                {palabrita}
            </p>
            <button onClick={() => setCount((count) => count + 1)}>
                Suma 1
            </button>
            <input onChange={(e) => setPalabrita(e.target.value)} type="text" placeholder="Escribe algo"/>
        </>
    );
};

export default App
