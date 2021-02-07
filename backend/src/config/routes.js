import { oneOf, param, query } from "express-validator";
import MemeController from "../controllers/MemeController";

export default (server) => {
    // all meme routes with input validation
    server.post(
        "/memes",
        [
            query("name").exists(),
            query("url").isURL(),
            query("caption").exists(),
        ],
        MemeController.insert
    );
    server.get("/memes", MemeController.getAll);
    server.get("/memes/:id", MemeController.getOne);
    server.patch(
        "/memes/:id",
        [
            param("id").exists(),
            oneOf([query("url").isURL(), query("caption").exists()]),
        ],
        MemeController.update
    );
    server.delete("/memes/:id", [param("id").exists()], MemeController.delete);
};
