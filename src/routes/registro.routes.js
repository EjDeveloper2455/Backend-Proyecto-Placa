import { Router} from "express";
import { methods as registro} from "./../controllers/registro.controller";
import { methods as auth} from "./../utils/auth";

const router = Router();

router.get("/:user",registro.getRegistroByUser);
router.post("/",registro.saveRegistro);

export default router;