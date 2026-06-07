import gql from "graphql-tag";


export const GET_SIMPLE_CHARACTERS= gql`
query GetSimpleCharacters {
        characters {
            results {
            id
            name
        }
    }
    }
    `;