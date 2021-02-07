import { MemeModal } from "../../config/database";

class MemeService {
    constructor() {
        this.getAll = this.getAll.bind(this);
        this.getOne = this.getOne.bind(this);
        this.insert = this.insert.bind(this);
        this.update = this.update.bind(this);
        this.delete = this.delete.bind(this);
    }

    async getAll() {
        try {
            const memes = await MemeModal.findAll({
                order: [["createdAt", "DESC"]],
                limit: 100,
            });
            return memes;
        } catch (errors) {
            return {
                code: 500,
                error: errors.array(),
            };
        }
    }

    async getOne(id) {
        try {
            const meme = await MemeModal.findAll({
                where: {
                    id: id,
                },
            });

            if (meme.length == 0)
                return {
                    code: 404,
                    error: "Meme not found",
                };

            return meme[0].dataValues;
        } catch (errors) {
            return {
                code: 500,
                error: errors.array(),
            };
        }
    }

    async insert(meme) {
        try {
            const res = await MemeModal.create(meme);
            return res.dataValues;
        } catch (errors) {
            return {
                code: 500,
                error: errors.array(),
            };
        }
    }

    async update(id, updatedMeme) {
        try {
            const res = await MemeModal.update(updatedMeme, {
                where: {
                    id: id,
                },
            });
            console.log(res);

            if (res[0] == 0)
                return {
                    code: 404,
                    error: "Meme not found",
                };

            return {
                message: "successfully updated",
            };
        } catch (errors) {
            return {
                code: 500,
                error: errors.array(),
            };
        }
    }

    async delete(id) {
        try {
            const res = await MemeModal.destroy({
                where: {
                    id: id,
                },
            });

            console.log(res);
            if (res == 0)
                return {
                    code: 404,
                    error: "Meme not found",
                };

            return {
                message: "successfully deleted",
            };
        } catch (errors) {
            return {
                code: 500,
                error: errors.array(),
            };
        }
    }
}

export default MemeService;
