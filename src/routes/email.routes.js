import { Router} from "express";
import { methods as email} from "./../controllers/email.controller";

const router = Router();

router.get("/:codigo/:destinatario",email.verificarEmail);
router.post("/enviar/",email.enviarEmail);
router.post("/",email.enviarConfirmacion);

export default router;