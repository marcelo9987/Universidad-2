import {ObjectId} from "mongodb";

export type Cochecito = {
    name: string;
    plate: string;
    age: number;
}

export type Usuario = {
    _id?: ObjectId;
    email: string;
    password: string;
}

export type JwtPayload = {
    id: string;
    email: string;
}

