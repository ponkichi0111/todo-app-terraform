// ToDoリストを取得して表示する関数
async function fetchTodos() {
  const res = await fetch('/todos');
  const todos = await res.json();
  const list = document.getElementById('todoList');
  
  // リストをクリア
  list.innerHTML = '';
  
  // ToDoをリストに追加
  todos.forEach(todo => {
    const li = document.createElement('li');
    li.innerText = todo.task;

    // 削除ボタンを作成
    const delBtn = document.createElement('button');
    delBtn.innerText = '削除';
    delBtn.onclick = () => deleteTodo(todo.id);

    // リスト項目に削除ボタンを追加
    li.appendChild(delBtn);
    list.appendChild(li);
  });
}

// 新しいタスクを追加する関数
async function addTask() {
  const taskInput = document.getElementById('taskInput');
  const task = taskInput.value.trim(); // 前後の空白を削除

  // 入力が空の場合は処理を中断
  if (!task) {
    return;
  }

  // サーバーに新しいタスクを送信
  await fetch('/todos', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ task })
  });

  // 入力欄をクリアし、最新のToDoリストを取得
  taskInput.value = '';
  fetchTodos();
}

// 指定されたIDのタスクを削除する関数
async function deleteTodo(id) {
  await fetch(`/todos/${id}`, { method: 'DELETE' });
  fetchTodos();
}

// ページロード時にToDoリストを取得
window.onload = fetchTodos;
