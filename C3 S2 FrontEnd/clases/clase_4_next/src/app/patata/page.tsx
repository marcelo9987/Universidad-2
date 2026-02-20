'use client';
import Link from "next/link";

import {router} from "next/navigation";

const PaginaPatata = () =>
{
    return (
        <div>
            <h1>Patata</h1>
            <p>Esta es la página de la patata.</p>
            <Link href="/">¿Ya no te gustan las patatas?</Link>
            <br/>
            <button onClick={
                () =>
                {
                    router.back();
                }
            }>Pa'tras
            </button>
        </div>
    );
};

export default PaginaPatata;