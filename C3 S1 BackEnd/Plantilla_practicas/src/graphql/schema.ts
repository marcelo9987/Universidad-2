import { gql } from

export const typeDefs = gql`
    type VideoGame {
        _id: ID
        , name: String
        , date: Date
        platform: String
        }
    type Query {
    videoGames: [VideoGame]
    videoGame(id: ID!): VideoGame
    }
    type Mutation {
    addVideoGame(name: String!, platform: String!, date: Date!): VideoGame
    }
    
    `