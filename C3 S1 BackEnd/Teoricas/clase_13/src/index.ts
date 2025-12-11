import {ApolloServer} from "apollo-server";
import {conectarBaseDeDatos} from "./db/mongo";
import {typeDefs} from "./graphql/schema";
import {resolvers} from "./graphql/resolver";

//--


const start = async () =>
{
    await conectarBaseDeDatos();

    const server = new ApolloServer({
        typeDefs,
        resolvers,
        context: ({req}) =>
        {
            return req;
        }
    });

    await server.listen({port: 1234});
    console.log("En marcha! Puerto de escucha: 1234");
};


start().catch(err => console.error(err));

