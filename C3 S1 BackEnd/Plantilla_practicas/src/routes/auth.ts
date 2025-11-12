import { Router } from "express";
import { conectarMongoDB, obtenerDB } from "../mongo";
import { ObjectId } from "mongodb";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import {JwtPayload, Usuario} from "../types";

const router = Router();

dotenv.config();

const SECRET = process.env.SECRET;


//todo: Poner en el .env?
const coleccion = () => obtenerDB().collection<Usuario>("UsersMorning");

router.get("/", async (req, res)=>{
    res.send("Conectado a auth con éxito");
});


router.post("/register", async (req, res) => {
    try{
        const {email, password} = req.body as {email:string, password:string};
        const usuarios = coleccion();

        const exists = await usuarios.findOne({email});
        if(exists){
            return res.status(400).json({message: "Email ya existente"})
        }

        const passEncripta = await bcrypt.hash(password,10);
        await usuarios.insertOne({email, password: passEncripta});

        res.status(201).json({message: "Usuario creado correctamente!"})

    }catch(err){
        res.status(500).json({message: err});
    }
});

router.post("/login", async (req, res)=>{
    try{
        const {email, password} = req.body as {email:string, password:string};

        const usuarios = coleccion();

        const user = await usuarios.findOne({email});
        if(!user) return res.status(404).json({message: "email incorrecto"});

        const validPass = await bcrypt.compare(password, user.password);
        if(!validPass) return res.status(404).json({message: "contraseña incorrecta"});

        console.log(user);
        console.log(SECRET);
        const token = jwt.sign({id: user._id?.toString(), email: user.email} as JwtPayload, SECRET as string, {
            expiresIn: "1h"
        });

        console.log(token);

        res.status(200).json({message: "Login correcto", token})

    }catch(err){
        res.status(500).json({message: err});
    }
})



export default router;