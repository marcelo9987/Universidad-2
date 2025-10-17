import express, {type NextFunction, type Request, type Response,} from "express";

import axios from "axios";

import cors from "cors";

type Team = {

    id: number;

    name: string;

    city: string;

    titles: number;

}

let teams: Team[] = [

    {id: 1, name: "Lakers", city: "Los Angeles", titles: 17},

    {id: 2, name: "Celtics", city: "Boston", titles: 17},

];

const app = express();
app.use(cors());
app.use(express.json());

/**
 * Valida los datos de un equipo
 * @param datos - Datos del equipo a validar
 * @returns Mensaje de error si hay campos faltantes, o null si todo está bien
 */
const validarEquipo = (datos: any): string | null =>
{
    if (!datos)
    {
        return "Se esperan parámetros de entrada";
    }

    const {name, city, titles} = datos;
    if (!name || !city || !titles)
    {
        return "Faltan campos obligatorios";
    }
    if (typeof name !== "string" || typeof city !== "string" || typeof titles !== "number")
    {
        return "ERROR!: Formato esperado: {name: string, city: string, titles: number}";
    }

    return null;
};

const extraerEquipo = (datos: any): Team =>
{
    const tamanhoBaseDeDatos = teams.length;

    const ultimoId = teams[tamanhoBaseDeDatos - 1]?.id ?? 0;
    const nuevoId: number = ultimoId === 0 ? ultimoId : ultimoId + 1;

    const nombre: string = datos.name;

    const ciudad: string = datos.city;

    const titulos: number = datos.titles;

    return {
        id: nuevoId, name: nombre, city: ciudad, titles: titulos
    };
};

const gestorDeErrores = (err: any, req: Request, res: Response, next: NextFunction) =>
{
    console.error("¡Detectado un error en la aplicación!:", err.message);
    res.status(500).json({error: "Error interno del servidor", detail: err.message});
};

const testApi = (async () =>
{
    await new Promise(resolve => setTimeout(resolve, 2000)); // damos 2 segundos de margen para que el servidor inicie
    console.log("Han pasado 2 segundos desde que el servidor se inició");

    {
        // 1-2. Obtener la lista de equipos (debería devolver los dos equipos iniciales)

        console.log("\n 1-2. Equipos en memoria:");
        const equipos = (await axios.get("http://localhost:3000/teams"));
        console.log(equipos.data, "\n");
    }

    // 3-5. Crear un nuevo equipo (Bulls de Chicago con 6 títulos)
    {
        console.log(" 3-5. Creación de los bulls, de Chicago con 6 titulos");
        try
        {
            const eq = await axios.post("http://localhost:3000/teams/", {
                "name": "Bulls", "city": "Chicago", "titles": 6
            });

            console.log(" Respuesta de la insercción:", eq.data, "\n");
        }
        catch (error: any)
        {
            console.log(" Error en la insercción:", error.response.data);
        }

        console.log(" 6-7. Equipos en memoria tras la insercción:");
        const equipos = (await axios.get("http://localhost:3000/teams")).data;
        console.log( equipos, "\n");
    }

    // 8-9. Eliminar el equipo recién creado (ID 3)
    {
        console.log(" 8. Eliminación del equipo con ID 3");
        try
        {
            const respuesta = await axios.delete("http://localhost:3000/teams/3");
            console.log(" Respuesta de la eliminación:", respuesta.data, "\n");
        }
        catch (error: any)
        {
            console.log(" Error en la eliminación:", error.response.data);
        }

        console.log(" 9. Equipos en memoria tras la eliminación:");
        const equipos = (await axios.get("http://localhost:3000/teams")).data;
        console.log(equipos, "\n");
    }

    console.log("Tests de la API finalizados.");

});

/// -**-**- RUTAS -**-**-

app.get("/", (req: Request, res: Response) =>
{
    res.send("¡Bienvenido a la API de equipos de baloncesto!");
});


app.get('/teams', (req: Request, res: Response) =>
{
    res.json(teams); //devuelve la lista de equipos en formato JSON de la «base de datos» (que es un array en memoria en este caso)
});


app.get('/teams/:id', (req: Request, res: Response) =>
{
    const {id} = req.params; // No se puede usar parseInt directamente en ID porque es de tipo string
    const numeroId = Number(id);
    if (isNaN(numeroId))
    {
        return res.status(400).json({error: "ID inválido"});
    }

    const equipo = teams.find((e) => e.id === numeroId);
    return equipo ? res.json(equipo) : res.status(404).json({error: "Equipo no encontrado"});
});

app.post('/teams', (req: Request, res: Response) =>
{
    try
    {
        const error = validarEquipo(req.body);
        if (error)
        {
            return res.status(400).json({error});
        }
        const nuevoEquipo = extraerEquipo(req.body);
        teams.push(nuevoEquipo);
        res.status(201).json(nuevoEquipo);
    }
    catch (err: any)
    {
        res.status(500).json({error: err.message});
    }
});

app.delete('/teams/:id', (req: Request, res: Response) =>
{
    try
    {
        const {id} = req.params;
        const numeroId = Number(id);
        if (isNaN(numeroId))
        {
            return res.status(400).json({error: "ID inválido"});
        }

        if (!teams.some((e) => e.id === numeroId))
        {
            return res.status(404).json({error: "No existe un equipo con ese ID"});
        }

        teams = teams.filter((e) => e.id !== numeroId);

        res.json({message: "Equipo eliminado correctamente"});
    }
    catch (err: any)
    {
        res.status(500).json({error: "Error all llevar a cabo la eliminación", detail: err.message});
    }
});

app.use((req: Request, res: Response) =>
{
    res.status(404).json({error: "Ruta no encontrada"});
});

app.use(gestorDeErrores);


app.listen(3000, () => console.log("Servidor en http://localhost:3000"));

await testApi();
