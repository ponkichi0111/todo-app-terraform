import React, { useEffect, useState } from "react";
import TodoInput from "./components/TodoInput";
import TodoList from "./components/TodoList";

const App = () => {
  const [todos, setTodos] = useState<{ id: number; title: string }[]>([]);

  useEffect(() => {
    fetch("/todos")
      .then((res) => res.json())
      .then(setTodos);
  }, []);

  const handleAdd = (title: string) => {
    fetch("/todos", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ title }),
    })
      .then((res) => res.json())
      .then((newTodo) => setTodos((prev) => [...prev, newTodo]));
  };

  const handleDelete = (id: number) => {
    fetch(`/todos/${id}`, { method: "DELETE" })
      .then(() => setTodos((prev) => prev.filter((todo) => todo.id !== id)));
  };

  return (
    <div>
      <h1>ToDo App</h1>
      <TodoInput onAdd={handleAdd} />
      <TodoList todos={todos} onDelete={handleDelete} />
    </div>
  );
};

export default App;