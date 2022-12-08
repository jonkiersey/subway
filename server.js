"use strict";

const express = require("express");
const route = require("./src/route.ts");
const trainLine = require("./src/train-line.ts");

// Constants
const PORT = 8080;
const HOST = "0.0.0.0";

// App
const app = express();
app.get("/", (req, res) => {
  res.send("Hello World");
});
app.get("/route", (req, res) => {
  const result = route.get(req);
  res.send(result);
});
app.post("/train-line", (req, res) => {
  const result = trainLine.post(req, res);
  res.status(201);
  res.send(result);
});

app.use((req, res) => {
  res.status(404);
  res.send("Not Found");
});

app.listen(PORT, HOST, () => {
  console.log(`Running on http://${HOST}:${PORT}`);
});
