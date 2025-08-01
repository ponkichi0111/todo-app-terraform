const express = require('express');
const cors = require('cors');
const app = express();
const todosRouter = require('./routes/todos');

app.use(cors());
app.use(express.json());
app.use('/todos', todosRouter);

app.listen(3000, () => console.log('Server running on port 3000'));
