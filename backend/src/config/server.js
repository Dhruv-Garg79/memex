import express from "express";
import bodyParser from "body-parser";
import setRoutes from "./routes";
import cors from 'cors';

const server = express();

server.use(cors());
server.use(bodyParser.json());
server.use(express.static('public'))

setRoutes(server);

export default server;
