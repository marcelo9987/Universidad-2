import {ObjectId} from "mongodb";

export type Game =
    {
        _id?: ObjectId
        title: string
        description: string
        price: number
        releaseYear: number
        genre: string
        developer: string
        reviews: Array<string>
    }
