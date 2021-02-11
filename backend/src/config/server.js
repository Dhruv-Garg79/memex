import express from "express";
import bodyParser from "body-parser";
import setRoutes from "./routes";
import cors from 'cors';

// Here we instantiate and setup our express server
const server = express();

server.use(cors());
server.use(bodyParser.json());

setRoutes(server);

export default server;
