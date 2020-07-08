const http = require('http');
const url = require('url');
const sqlite3 = require('sqlite3').verbose();
var db = new sqlite3.Database('./database.db');
// db.run("DROP TABLE if exists transacoes");
// db.run("DROP TABLE if exists contatos");
db.run("CREATE TABLE if not exists contatos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, numero_conta INTEGER UNIQUE)");
db.run("CREATE TABLE if not exists transacoes (uuid TEXT PRIMARY KEY, valor DOUBLE, contato INTEGER)");

const host = 'localhost';
const port = 3000;

const server = http.createServer((req, res) => {
    res.setHeader('Content-Type', 'application/json');
    const objUrl = url.parse(req.url, true);

    if (objUrl.pathname == '/contato' && req.method == 'GET') {
        db.all("SELECT * FROM contatos", function(err, rows) {
            if (err) return res.writeHead(500).end('erro');
            return res.writeHead(200).end(JSON.stringify(rows));
        });
    } else if (objUrl.pathname == '/contato' && req.method == 'POST') {
        db.run(
            'INSERT INTO contatos (nome, numero_conta) VALUES (?, ?)', 
            [objUrl.query.nome, objUrl.query.numero_conta],
            (err) => {
                if (err) return res.writeHead(500).end('erro');
                return res.writeHead(201).end();
            });
    } else if (objUrl.pathname == '/transacao' && req.method == 'GET') {
        db.all('SELECT transacoes.valor, contatos.id, contatos.nome, contatos.numero_conta ' + 
                'FROM transacoes ' + 
                'LEFT JOIN contatos on contatos.id = transacoes.contato', function(err, rows) {
            if (err) return res.writeHead(500).end('erro');
            var response = rows.map(function(row) {
                return {
                    valor: row.valor,
                    contato: {
                        id: row.id,
                        nome: row.nome,
                        numero_conta: row.numero_conta,
                    },
                };
            });
            return res.writeHead(200).end(JSON.stringify(response));
        });
    } else if (objUrl.pathname == '/transacao' && req.method == 'POST') {
        if (req.headers.password != 1000) {
            return res.writeHead(401).end('erro');
        }

        var body = '';
        req.on('data', function (data) {
            body += data;
            // 1e6 === 1 * Math.pow(10, 6) === 1 * 1000000 ~~~ 1MB
            if (body.length > 1e6) { 
                // FLOOD ATTACK OR FAULTY CLIENT, NUKE REQUEST
                body = '';
                res.writeHead(413).end();
                req.connection.destroy();
            }
        });
        req.on('end', function () {
            var jsonPost = JSON.parse(body);
            if (jsonPost.valor <= 0) {
                console.log('valor inválido');
                return res.writeHead(422).end('valor inválido');
            }
            db.get('SELECT uuid FROM transacoes WHERE uuid = ?', [jsonPost.uuid], (err, row) => {
                if (err) return res.writeHead(400).end('erro');
                console.log(row);
                if (row) return res.writeHead(409).end('transacao ja existe');
                db.run('INSERT OR IGNORE INTO contatos (nome, numero_conta) VALUES (?, ?)', [jsonPost.contato.nome, jsonPost.contato.numero_conta]);
                db.get('SELECT id FROM contatos WHERE numero_conta = ?', [jsonPost.contato.numero_conta], (err, row) => {
                    if (err) return res.writeHead(400).end('erro');
                    db.run(
                        'INSERT INTO transacoes (uuid, valor, contato) VALUES (?, ?, ?)', 
                        [jsonPost.uuid, jsonPost.valor, row.id],
                        (err) => {
                            if (err) return res.writeHead(400).end('erro');
                            console.log('gravado', jsonPost.valor, row.id);
                            return res.writeHead(201).end();
                        });
                });
            });
        });

        
    } else {
        return res.writeHead(400).end('erro');
    }
});

// db.close();

server.listen(port, () => {
    console.log(`Servidor iniciou em http://${host}:${port}/`)
});
