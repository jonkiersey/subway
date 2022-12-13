"use strict";

import express from "express";
import route from "./route";
import trainLine from "./train-line";

// Constants
const PORT = 8080;
const HOST = "0.0.0.0";

// App
const app = express();
app.use(express.json()); // for parsing application/json
app.get("/", (req, res) => {
  res.send("Hello World");
});
app.get("/route", async (req, res) => {
  const result = await route.get(req);
  res.send(result);
});
app.post("/train-line", async (req, res) => {
  try {
    const result = await trainLine.post(req);
    res.status(201);
    res.send(result);
  } catch (err) {
    res.status(500);
    res.send(err);
  }
});

app.use((req, res) => {
  res.status(404);
  res.send("Not Found");
});

app.listen(PORT, HOST, () => {
  console.log(`Running on http://${HOST}:${PORT}`);
});
