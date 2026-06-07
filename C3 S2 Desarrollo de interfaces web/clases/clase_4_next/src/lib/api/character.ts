import {api} from "./axios";
import {Character} from "@/types";


export const getCharacterById = async (id: number) =>
{
    const response = await api.get<Character>(`/character/${id}`);
    return response.data;
}