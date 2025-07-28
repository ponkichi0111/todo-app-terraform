import express, { Request, Response, NextFunction, ErrorRequestHandler } from "express";
import cors from "cors";
import { PrismaClient } from '@prisma/client';

const app = express();
const prisma = new PrismaClient();
const PORT = process.env.PORT || 4000;

// CORSの詳細設定
app.use(cors({
  origin: process.env.FRONTEND_URL || 'http://localhost:3000',
  methods: ['GET', 'POST', 'DELETE'],
  credentials: true
}));
app.use(express.json());

// エラーハンドリングミドルウェア
const errorHandler: ErrorRequestHandler = (
  err: Error,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  console.error(err.stack);
  res.status(500).json({ 
    error: 'エラーが発生しました',
    message: err.message 
  });
};

// APIエンドポイント
app.get("/todos", async (req, res, next) => {
  try {
    const todos = await prisma.todo.findMany();
    res.json(todos);
  } catch (error) {
    next(error);
  }
});

app.post("/todos", async (req, res, next) => {
  try {
    const { title } = req.body;
    if (!title) {
      return res.status(400).json({ error: 'Title is required' });
    }
    const todo = await prisma.todo.create({
      data: { title }
    });
    res.status(201).json(todo);
  } catch (error) {
    next(error);
  }
});

app.delete("/todos/:id", async (req, res, next) => {
  try {
    const id = parseInt(req.params.id);
    await prisma.todo.delete({
      where: { id }
    });
    res.status(204).send();
  } catch (error) {
    next(error);
  }
});

app.use(errorHandler);

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});