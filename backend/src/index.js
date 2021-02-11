import { sequelize } from "./config/database";
import server from "./config/server";
import express from "express";

const PORT = process.env.PORT || 8081;

//starts server once database connection is ready
sequelize.sync().then(() => {
    server.listen(PORT, () => {
        console.log(`app running on port ${PORT}`);
    });
});

// serves swagger-ui
const swaggerServer = express();
swaggerServer.get("/swagger-ui", function (req, res) {
    console.log(__dirname);
    res.sendFile("public/swagger-ui.html", { root: '.' });
});

swaggerServer.listen(8080, () => {
    console.log(`swagger running on port 8080`);
});
