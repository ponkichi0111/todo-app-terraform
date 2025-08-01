async function fetchTodos() {
  const res = await fetch('/todos');
  const todos = await res.json();
  const list = document.getElementById('todoList');
  list.innerHTML = '';
  todos.forEach(todo => {
    const li = document.createElement('li');
    li.innerText = todo.task;
    const delBtn = document.createElement('button');
    delBtn.innerText = '削除';
    delBtn.onclick = () => deleteTodo(todo.id);
    li.appendChild(delBtn);
    list.appendChild(li);
  });
}

async function addTask() {
  const taskInput = document.getElementById('taskInput');
  const task = taskInput.value;
  await fetch('/todos', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ task })
  });
  taskInput.value = ''; // 入力フィールドをクリア
  fetchTodos();
}

async function deleteTodo(id) {
  await fetch(`/todos/${id}`, { method: 'DELETE' });
  fetchTodos();
}

window.onload = fetchTodos;
