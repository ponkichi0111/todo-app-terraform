// 必要なモジュールをインポート
const express = require('express');
const cors = require('cors');
const todosRouter = require('./routes/todos');

// Expressアプリケーションを作成
const app = express();

// ミドルウェアの設定
app.use(cors({
  origin: '*',  // 本番環境では適切なオリジンに制限すべき
  methods: ['GET', 'POST', 'DELETE'],
  allowedHeaders: ['Content-Type']
}));
app.use(express.json());

// ルートの設定
app.use('/todos', todosRouter);

// サーバーを起動
const PORT = 4000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
