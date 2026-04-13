'use client'
import gql from "graphql-tag";
import {useQuery} from "@apollo/client/react";
import {GetSimpleCharactersQuery, GetSimpleCharactersQueryVariables} from "@/gql/graphql";
import {GET_SIMPLE_CHARACTERS} from "@/features/characters/queries";

const  home = () =>
{
    const {data,loading} = useQuery<GetSimpleCharactersQuery, GetSimpleCharactersQueryVariables>(GET_SIMPLE_CHARACTERS)
    return (<div>
    <h1>Characters</h1>
    {loading && <p>Loading...</p>}
    {!loading && data?.characters?.results?.map((character) => (
        <div key={character?.id}>
            <p>{character?.name}</p>
        </div>
    ))}
    </div>)
}

export default home;
