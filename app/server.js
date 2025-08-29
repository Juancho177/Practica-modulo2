const http = require('http');
const os = require('os');

const PORT = process.env.PORT || 3000;
const hostname = os.hostname();

function json(res, code, obj) {
  res.writeHead(code, {'Content-Type': 'application/json'});
  res.end(JSON.stringify(obj));
}

const server = http.createServer((req, res) => {
  if (req.url === '/health') {
    return json(res, 200, {status: 'ok', node: hostname});
  }
  return json(res, 200, {
    message: 'Hola desde Node.js a través de HAProxy + Consul',
    node: hostname,
    time: new Date().toISOString()
  });
});

server.listen(PORT, '0.0.0.0', () => {
  console.log(`Servidor web escuchando en puerto ${PORT}`);
});
