import { Router} from "express";
import { methods as auth} from "../utils/auth";

const router = Router();

router.post("/",auth.signUp);
router.post("/login/",auth.login);
router.post("/verificar/:token",auth.verifyToken);
router.post("/decodificar/:token",auth.decodedToken);

export default router;