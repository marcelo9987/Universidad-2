fetch("https://rickandmortyapi.com/api/character/9978798654864845").then
(
    (response) =>
    {
        const data = response.json();

        data.then
        (
            (info)=>
            {
                console.log(info);
            }
        )
    }
).catch
(
    (error) =>
    {
        console.log("Error en la petición", error);
    }
).finally
(
    ()=>
    {
        console.log("Finalizando...");
    }
)

console.log("Código después de la petición fetch");
