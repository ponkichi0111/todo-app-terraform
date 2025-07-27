import React, { useState } from "react";

type Props = {
  onAdd: (text: string) => void;
};

const TodoInput: React.FC<Props> = ({ onAdd }) => {
  const [text, setText] = useState("");

  const handleAdd = () => {
    if (text.trim()) {
      onAdd(text);
      setText("");
    }
  };

  return (
    <div>
      <input value={text} onChange={(e) => setText(e.target.value)} />
      <button onClick={handleAdd}>追加</button>
    </div>
  );
};

export default TodoInput;