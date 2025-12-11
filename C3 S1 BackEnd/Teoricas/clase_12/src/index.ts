import {resolvers} from "./resolver";
import {ApolloServer} from "apollo-server";
import {typeDefs} from "./schema";


const server = new ApolloServer({ typeDefs, resolvers });

const servidorEscuchando = server.listen({port: 4000});

servidorEscuchando.then(({url}) => {
    console.log(`Servidor listo en la URL ${url} `);
});

