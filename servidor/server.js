const WebSocket = require('ws');
const mysql = require('mysql2/promise');

const banco = mysql.createPool({
    host: '172.16.0.30',
    port: 3306,
    user: 'conlar',
    password: 'SUA_SENHA_DO_SERVIDOR',
    database: 'conlar_conectar',
    waitForConnections: true,
    connectionLimit: 10
});

const servidor = new WebSocket.Server({
    port: 3000,
    host: '0.0.0.0'
});

console.log('Servidor do ConectaLar iniciado na porta 3000');

servidor.on('connection', async (socket, request) => {

    console.log('Novo usuario conectado');

    socket.on('message', async (dados) => {

        try {
            const informacao = JSON.parse(dados.toString());

            if (informacao.tipo !== 'mensagem') {
                return;
            }

            const nome = informacao.nome;
            const cep = informacao.cep;
            const mensagem = informacao.mensagem.trim();

            if (!nome || !cep || !mensagem) {
                return;
            }

            const [resultado] = await banco.execute(
                `
                INSERT INTO mensagens
                (
                    nome_usuario,
                    cep_comunidade,
                    mensagem
                )
                VALUES (?, ?, ?)
                `,
                [nome, cep, mensagem]
            );

            const novaMensagem = {
                tipo: 'nova_mensagem',
                id: resultado.insertId,
                nome_usuario: nome,
                cep_comunidade: cep,
                mensagem: mensagem
            };

            servidor.clients.forEach((cliente) => {

                if (cliente.readyState === WebSocket.OPEN) {

                    cliente.send(
                        JSON.stringify(novaMensagem)
                    );

                }

            });

        } catch (erro) {

            console.error(
                'Erro ao processar mensagem:',
                erro
            );

        }

    });

    socket.on('close', () => {
        console.log('Usuario desconectado');
    });

});