import {User} from "./User";
import {ObjectId} from "mongodb";

export type Review=
{
    id?: ObjectId
    content: string
    rating: number
    author: string
}