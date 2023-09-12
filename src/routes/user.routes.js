import { Router} from "express";
import { methods as auth} from "../utils/auth";

const router = Router();

router.post("/",auth.signUp);
router.post("/login/",auth.login);
router.get("/verificar/:token",auth.verifyToken);
router.get("/decodificar/:token",auth.decodedToken);

export default router;