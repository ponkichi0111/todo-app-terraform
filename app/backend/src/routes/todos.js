const express = require('express');
const router = express.Router();
const db = require('../models/db');

router.get('/', async (req, res) => {
  const [rows] = await db.query('SELECT * FROM todos');
  res.json(rows);
});

router.post('/', async (req, res) => {
  const { task } = req.body;
  await db.query('INSERT INTO todos (task) VALUES (?)', [task]);
  res.sendStatus(201);
});

router.delete('/:id', async (req, res) => {
  await db.query('DELETE FROM todos WHERE id = ?', [req.params.id]);
  res.sendStatus(204);
});

module.exports = router;
