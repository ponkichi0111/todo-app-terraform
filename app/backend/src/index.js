// 必要なモジュールをインポート
const express = require('express');
const cors = require('cors');
const todosRouter = require('./routes/todos');

// Expressアプリケーションを作成
const app = express();

// ミドルウェアの設定
app.use(cors());
app.use(express.json());

// ルートの設定
app.use('/todos', todosRouter);

// サーバーを起動
const PORT = 4000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
