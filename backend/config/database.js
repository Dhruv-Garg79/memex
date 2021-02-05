import Sequelize from "sequelize";
require('dotenv').config();
console.log(process.env.DATABASE);

const sequelize = new Sequelize(
    process.env.DATABASE,
    process.env.DATABASE_USER,
    process.env.DATABASE_PASSWORD,
    {
        host: process.env.DATABASE_HOST,
        port: process.env.DATABASE_PORT,
        dialect: "postgres",
        dialectOptions: {
            ssl: {
                require: true,
                rejectUnauthorized: false,
            },
        },
    }
);

const MemeModal = sequelize.import("../src/models/meme.js");

export { sequelize, MemeModal };
