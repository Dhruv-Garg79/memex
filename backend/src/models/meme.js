import { sequelize } from "../config/database";

const meme = (sequelize, type) => {
    const Meme = sequelize.define("meme", {
        id: {
            type: type.INTEGER,
            primaryKey: true,
            autoIncrement: true,
        },
        name: {
            type: type.STRING,
            allowNull: false,
            validate: {
                notEmpty: true,
            },
        },
        caption: {
            type: type.STRING,
            allowNull: false,
            validate: {
                notEmpty: true,
            },
        },
        url: {
            type: type.STRING,
            allowNull: false,
            validate: {
                notEmpty: true,
            },
        },
    });

    return Meme;
};

export default meme;
