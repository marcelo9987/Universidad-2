import {Game} from "./Game";
import {ObjectId} from "mongodb";

export type Developer =
{
    _id?: ObjectId
    name: string
    country?: string
    foundedYear?: number
    games: Array<string>
}