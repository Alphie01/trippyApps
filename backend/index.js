const express = require('express');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

// Örnek kullanıcı bilgileri
const users = [
  { id: 1, username: 'user1', password: 'pass1' },
  { id: 2, username: 'user2', password: 'pass2' },
];

// Giriş yapan kullanıcıları saklamak için basit bir nesne
const loggedInUsers = {};

// Kullanıcı giriş işlemi
app.post('/login', (req, res) => {
  console.log(req.body);
  const { username, password } = req.body;
  const user = users.find((u) => u.username === username && u.password === password);

  if (user) {
    const token = generateToken();
    loggedInUsers[token] = user;
    res.json({ token, user });
  } else {
    res.status(401).json({ message: 'Kullanıcı adı veya şifre hatalı.' });
  }
});

// Token oluşturma işlemi (simülasyon amaçlı, gerçek uygulamalarda farklı bir yöntem kullanılmalıdır)
function generateToken() {
  return Math.random().toString(36).substr(2) + Date.now().toString(36);
}

// Kullanıcı bilgilerini kontrol etmek için bir ara katman
function authenticateUser(req, res, next) {
  const token = req.headers.authorization;

  if (loggedInUsers[token]) {
    req.user = loggedInUsers[token];
    next();
  } else {
    res.status(401).json({ message: 'Yetkisiz erişim. Lütfen giriş yapın.' });
  }
}

// Örnek korumalı bir rotaya örnek
app.get('/profile', authenticateUser, (req, res) => {
  const user = req.user;
  res.json({ message: `Hoş geldin, ${user.username}!` });
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Sunucu çalışıyor, http://localhost:${PORT}`));
