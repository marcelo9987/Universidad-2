import { gql } from 'apollo-server';



export const typeDefs = gql`
    type User{
    _id: ID!
    email: String!
    clothes: [Clothing]! # testme
    }
    
    type Clothing{
    _id: ID!
    name: String!
    size: String!
    color: String!
    price: Float!
    }
    
    type Query{
        me: User #tested
        clothes(page: Int, size: Int): [Clothing]! # fixme
        clothing(id: ID!): Clothing # testme
    }
    
    type Mutation{
        register(email: String!, password: String!): String! #tested
        login(email: String!, password: String!): String! #tested
        addClothing(name: String!, size: String!, color: String!, price: Float!): Clothing! #testme
        buyClothing(id: ID!): User! #testme
    }
    
`;