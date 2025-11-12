import { Router } from "express";
import { authRequest, verifyToken } from "../middleware/verifyToken";


const router = Router();

router.get("/user", verifyToken, (req: authRequest, res) => {
    res.json({
        message: "Acceso correcto",
        user: req.user
    })
});

export default router;