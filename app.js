const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.json({ message: 'Hello from Custom Build Environment!' });
});

module.exports = app;
