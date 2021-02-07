import { sequelize } from "./config/database";
import server from "./config/server";

const PORT = process.env.PORT || 8081;

sequelize.sync().then(() => {
    server.listen(PORT, () => {
        console.log(`app running on port ${PORT}`);
    });
});

// git subtree push --prefix backend heroku master