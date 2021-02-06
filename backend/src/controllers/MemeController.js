import { validationResult } from "express-validator";
import MemeService from "../services/MemeService";

class MemeController {
    constructor(service) {
        this.service = service;
        this.getAll = this.getAll.bind(this);
        this.getOne = this.getOne.bind(this);
        this.insert = this.insert.bind(this);
        this.update = this.update.bind(this);
        this.delete = this.delete.bind(this);
    }

    async getAll(req, res) {
        const memes = await this.service.getAll();
        if (memes.error) return res.status(meme.code).json(memes.error);

        return res.status(200).json(memes);
    }

    async getOne(req, res) {
        const meme = await this.service.getOne(req.params.id);
        console.log(meme);
        if (meme.error)
            return res.status(meme.code).json({ error: meme.error });

        return res.status(200).json(meme);
    }

    async insert(req, res) {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(422).json({ error: errors.array() });
        }

        const meme = await this.service.insert({
            name: req.query.name,
            caption: req.query.caption,
            url: req.query.url,
        });

        if (meme.error) {
            return res.status(meme.code).json({ error: meme.error });
        }

        return res.status(200).json({
            id: meme.id,
        });
    }

    async update(req, res) {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            return res.status(422).json({ error: errors.array() });
        }

        const updatedMeme = {};
        if (req.query.url) updatedMeme.url = req.query.url;
        if (req.query.caption) updatedMeme.caption = req.query.caption;

        const meme = await this.service.update(req.params.id, updatedMeme);

        if (meme.error) {
            return res.status(meme.code).json({ error: meme.error });
        }

        return res.status(200).json(meme);
    }

    async delete(req, res) {
        const response = await this.service.delete(req.params.id);
        console.log(response);
        if (response.error)
            return res.status(response.code).json({ error: response.error });

        return res.status(200).json(response);
    }
}

export default new MemeController(new MemeService());
