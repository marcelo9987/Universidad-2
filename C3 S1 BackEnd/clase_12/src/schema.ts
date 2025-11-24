import {gql} from 'apollo-server';

export const typeDefs = gql`

    type Coche{
        id: ID!
        , name: String
        , brand: String
        , plate: String
    }
    
    type Query {
        getCoches: [Coche!]
        , getCoche(id: ID!): Coche
    }
    
    type Mutation {
        addCoche(name: String!, brand: String!, plate: String!): Coche!
    }
`;

