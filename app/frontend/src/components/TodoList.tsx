import React from "react";

type Todo = {
  id: number;
  title: string;
};

type Props = {
  todos: Todo[];
  onDelete: (id: number) => void;
};

const TodoList: React.FC<Props> = ({ todos, onDelete }) => {
  return (
    <ul>
      {todos.map((todo) => (
        <li key={todo.id}>
          {todo.title} <button onClick={() => onDelete(todo.id)}>削除</button>
        </li>
      ))}
    </ul>
  );
};

export default TodoList;