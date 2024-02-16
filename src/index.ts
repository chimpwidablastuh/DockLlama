import ollama from "ollama";
import express from "express";
import * as dotenv from "dotenv";

dotenv.config();

const app = express();

app.use(express.json());

app.get("/", (req, res) => {
  res.send("Welcome to Ollama web server. Use /chat to chat with Ollama");
});

app.post("/chat", async (req, res) => {
  const response = await ollama.chat({
    model: process.env.MODEL || "llama2",
    messages: [{ role: "user", content: req.body.message }],
  });
  res.json({ answer: response.message.content });
});

app.listen(3000, () => {
  console.log("Ollama chat server running on ::3000");
});
