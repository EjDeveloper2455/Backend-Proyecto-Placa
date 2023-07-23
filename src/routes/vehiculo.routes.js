import { Router} from "express";
import { methods as vehiculo} from "./../controllers/vehiculo.controller";

const router = Router();

router.get("/",vehiculo.getVehiculos);
router.post("/",vehiculo.saveVehiculo);

export default router;