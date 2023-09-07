import { Router} from "express";
import { methods as registro} from "./../controllers/registro.controller";

const router = Router();

router.get("/:user",registro.getRegistroByUser);
router.post("/",registro.saveRegistro);

export default router;