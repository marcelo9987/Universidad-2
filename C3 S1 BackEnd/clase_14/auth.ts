import {ObjectId} from "mongodb";

const secreto: string = process.env.SECRETO;
import jwt from "jsonwebtoken";
import {obtenerBaseDeDatos} from "./src/db/mongo";

type TokenPayload =
    {
        userId: string
    };

export const signToken = (userId: string): string =>
{
    jwt.sign({userId} as TokenPayload, secreto, {expiresIn: '1h'});
};

export const verifyToken = (token: string): TokenPayload|null =>
{
    try
    {
        return jwt.verify(token, secreto) as TokenPayload;
    }
    catch (error)
    {
        console.error('Token verification failed:', error);
        return null;
    }
}

export const getUserFromToken =  async (token: string) =>
{
    const payload = verifyToken(token);
    if (!payload)
    {
        return null;
    }
    const db = obtenerBaseDeDatos();
    return await db.collection('users').findOne({_id: new ObjectId(payload.userId)});

}
