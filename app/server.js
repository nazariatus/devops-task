'use strict';

const express = require('express');
const bodyParser = require('body-parser');

const { API_PORT, API_VERSION } = process.env;

if (!API_PORT) {
  throw new Error('No port specified');
}

function assignVersion(payload) {
  return Object.assign(payload, { version: API_VERSION });
}

function calculateToken() {
  return Math.round(Math.random() * 1e16);
}

const app = express();

app.use(bodyParser.json());

app.get('/', (req, res) => {
  const payload = assignVersion({ 
    data: 'Hello world!',
    token: calculateToken()
  });
  
  res.json(payload);
});

app.get('/ring-ring', (req, res) => {
  const payload = assignVersion({ 
    data: 'Hello, this is API speaking!',
    token: calculateToken()
  });
  
  res.json(payload);
});

app.use((req, res, next) => {
  res.status(404).json({ error: 'route not found', code: 404 });
});

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something broke', code: 500 });
});

app.listen(API_PORT);

