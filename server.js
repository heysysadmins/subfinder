// server.js
const express = require("express");
const cors = require("cors");
const { exec } = require("child_process");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());

app.get("/subdomains", (req, res) => {
  const domain = req.query.domain;
  if (!domain) return res.status(400).json({ error: "Missing domain" });

  exec(`subfinder -d ${domain} -silent`, (err, stdout, stderr) => {
    if (err) {
      console.error(stderr);
      return res.status(500).json({ error: "Failed to run subfinder" });
    }

    const subdomains = stdout.split("\n").filter(Boolean);
    res.json({ domain, subdomains });
  });
});

app.listen(PORT, () => console.log(`Listening on port ${PORT}`));

