import { Router} from "express";
import { methods as consultar} from "./../controllers/consultar.controller";

const router = Router();

router.get("/:placa",consultar.getConsulta);

export default router;