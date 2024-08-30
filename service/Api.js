const express = require('express');
const session = require('express-session');
const parser = require('body-parser');
const MySql = require('mysql');
const cors = require('cors');
//este serve para gerar token do usuario
const jwt = require('jsonwebtoken');
//criando aplicação
const app = express();
//rotas da aplicação
const router = express.Router();
//porta da aplicação
const PORTA = 3000;
//criar conexão com mysql
//NOME DA TABELA PARA INSERIR DADOS DE USUARIO
var nomeDaTabela = "credenciais";
//variavel DB do mysql
const db = MySql.createConnection({
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': `MovieMaster`
})
//cors
app.use(cors());
// Usando o middleware para parsear JSON
app.use(express.json());

// Usando o middleware para parsear dados de formulário
app.use(express.urlencoded({ extended: true }));
//verificar token
function VerifyToken(req,res,next){
    //busca token
    const token = req.headers['authorization'];
    //ve se tem token
    if(!token)return res.sendStatus(403);

    jwt.verify(token, 'secreto', (err, user)=>{
        if(err) return res.sendStatus(403);

    // Verifica se o token está na lista de tokens revogados no banco de dados
    const sql = 'SELECT * FROM tokensRevogados WHERE token = ?';
    db.query(sql, [token], (dbErr, result) => {
        if (dbErr) return res.status(500).json({ error: "Erro ao verificar o token no banco de dados" });

        if (result.length > 0) {
                // Se o token estiver na lista de tokens revogados, retorna status 403
            return res.sendStatus(403);
            }

        req.user = user;
        next();
    })})};


//Cadastro dos dados
app.post('/registerPage/cadastro',(req,res)=>{
    //coletando nome e senha
    const {nome,email, senha}= req.body;
    //verificando valor destas
    console.log(`Respectivamente as variaveis: ${nome,email, senha}`);
    //variavel com comando SLQ para inserir dados na tabela credenciais
    const InserirDadosSQL = `INSERT INTO ${nomeDaTabela} (nome, email, senha) VALUES (?,?,SHA2(?, 256))`;
    //salvar esses dados em um banco de dados próprio do usuário
    db.query(InserirDadosSQL,[nome,email,senha],(err,resposta)=>{
        if(err){
            console.log(`Erro Ao inserir Dados na tabela de cadastro na RegisterPage, segue o erro: ${err}`);
            return;
        }else{
            //gerando o id automático
            const id = resposta.insertId;
            //token para validação
            const token = jwt.sign({ id, nome }, 'secreto', { expiresIn: '30d' });
            //envio do token mais resposta da API
            res.json({Mensagem: `Cadastro da RegisterPage Realizado com Sucesso!${resposta}`,nome, token});
        }
    })

});
//login do usuário
app.post('/loginPage/login',(req,res)=>{
    //coletando email e senha
    const {emailEnome, senha}= req.body;
    //VERIFICANDO VALORES QUE CHEGARAM
    console.log(`VERIFICANDO VALORES QUE CHEGARAM Email ou Nome : ${emailEnome} senha: ${senha}`);
    //comando slq para verificar valoress
    //neste comando sql eu seleciono o nome para salvar localmente e usar na aplicação
    //também coloco uma comparação aonde se o nome ou email estiver correto o usuario é aprovado
    const ValidarDadosSQL = `
        SELECT id, nome, email 
        FROM ${nomeDaTabela} 
        WHERE (email = ? OR nome = ?) 
        AND senha = SHA2(?, 256)`;
    //verificar dados do SQL
    db.query(ValidarDadosSQL,[emailEnome, emailEnome, senha],(err,resposta)=>{
        if(err){
            console.log(`Erro Ao verificar Dados na tabela de cadastro na LoginPage, segue o erro: ${err}`);
            return res.status(500).json({ Mensagem: "Erro interno do servidor." });
        }
        if (resposta.length === 0) {
            // Nenhum usuário encontrado
            return res.status(401).json({ Mensagem: "Usuário ou senha inválidos." });
        }
            //coletando os dados 
            const {id, nome, email} =   resposta[0];
            const nomeResposta = nome;
            //token para validação
            const token = jwt.sign({ id, nomeResposta }, 'secreto', { expiresIn: '30d' });
            //envio do token mais resposta da API
            res.json({Mensagem: `Login da LoginPage Realizado com Sucesso!${resposta}`,nomeResposta, token, email});
        
    })
});
//atualizar os dados do usuario 

//rota da homepage
app.get('/homePage', VerifyToken,( req, res)=>{
    res.json({Mensagem: `Acessado a HomePage ROTA GET com sucesso!`})
});
//deslogar usuario
app.post('/logout',(req,res)=>{
    //verificações
    const autorizacaoHeader = req.headers['authorization'];
    if (!autorizacaoHeader) {
        return res.status(400).json({ Mensagem: "Token não fornecido!" });
    }
    const token = autorizacaoHeader.split(' ')[1];

    if (!token) {
        return res.status(400).json({ Mensagem: "Token não fornecido!" });
    }
    

    let tokenDecodificado;
    try {
        tokenDecodificado = jwt.decode(token);
        if (!tokenDecodificado || !tokenDecodificado.exp) {
            return res.status(400).json({ Mensagem: "Token inválido!" });
        }
    } catch (error) {
        return res.status(400).json({ Mensagem: "Erro ao decodificar o token!" });
    }

    const tempoToken = tokenDecodificado.exp * 1000; // Calculando o tempo em ms do token

    //comando sql para inserir este token velho e invalido em uma tabela  sql
    const InjetarTokenNaTabela = "INSERT INTO tokensRevogados (token, tempoExpirado) VALUES (?, ?)";
    //injetando pela query
    db.query(InjetarTokenNaTabela,[token, new Date(tempoToken)],(err)=>{
        if(err){
            console.log(`Erro ao adicionar token à tabela: ${err}`);
            return res.status(500).json({ Mensagem: "Erro interno do servidor ao realizar logout!" });
        }
        console.log("Logout realizado com sucesso!");
        res.json({ Mensagem: "Logout realizado com sucesso!" });
    })
});
//funções de atualização de informações do usuario
//para atualizar devo receber esses dados da API antes
app.get('/UserPage/ColetarDadosDoUsuario',VerifyToken,(req,res)=>{
    //requerindo id do usuario
    const idDoUsuario = req.user.id;
    //verificando o id
    console.log(`Segue o valor do  Id: ${req.user.id}`);
    // Verifica se o ID foi encontrado
    if (!idDoUsuario) {
        return res.status(400).json({ mensagem: 'ID do usuário não encontrado' });
    }
    //comando sql para buscar dados
    const BuscarDadosDoUsuario = `SELECT nome, email FROM ${nomeDaTabela} WHERE id = ?`;
    //buscando
    db.query(BuscarDadosDoUsuario,[idDoUsuario],(erro,resposta)=>{
        if(erro){
            console.error(`Segue o erro ao buscar os dados do usuário ${erro}`);
            return res.status(500).json({ mensagem: 'Erro ao buscar dados do usuário' });
        }
        if (resposta.length === 0) {
            return res.status(404).json({ mensagem: 'Usuário não encontrado' });
        }
        //buscando os dados
        const {nome, email} = resposta[0];
        res.json({ mensagem: 'Dados coletados com sucesso', nome, email });
    })
});
//UPDATE
app.put("/UserPage/AtualizarDadosDoUsuario",VerifyToken, (req,res)=>{
    //requerindo id do usuario
    const idDoUsuario = req.user.id;
    //requerindo os dados do usuario alterados
    const { nome, email} = req.body;
    //comando SLQ
    const InjetarNovosDados = `UPDATE ${nomeDaTabela} SET nome = ?, email = ? WHERE id = ?`;
    //injetantado os dados
    db.query(InjetarNovosDados,[nome, email, idDoUsuario],(erro, resposta)=>{
        if(erro){
            console.error(`Segue o erro: ${erro} no momento de atualizar os dados`);
            return res.status(500).json({ mensagem: 'Erro ao atualizar dados do usuário'});
        }
        if (resposta.affectedRows > 0) {
            res.json({ mensagem: 'Dados do usuário atualizados com sucesso' });
        } else {
            res.status(404).json({ mensagem: 'Usuário não encontrado', nome });
        }
    })
})
//atualizar senha do usuárip
app.put('/UserPage/AtualizarSenhaDoUsuario', VerifyToken, (req,res)=>{
    //requerindo id do usuario
    const idDoUsuario = req.user.id;
    //requerindo os dados do usuario alterados
    const {senha} = req.body;
    //comando SLQ
    const InjetarNovosDados = `UPDATE ${nomeDaTabela} SET senha = SHA2(?, 256) WHERE id = ?`;
    //injetantado os dados
    db.query(InjetarNovosDados,[senha, idDoUsuario],(erro, resposta)=>{
        if(erro){
            console.error(`Segue o erro: ${erro} no momento de atualizar os dados`);
            return res.status(500).json({ mensagem: 'Erro ao atualizar dados do usuário'});
        }
        if (resposta.affectedRows > 0) {
            res.json({ mensagem: 'Senha do usuário atualizados com sucesso' });
        } else {
            res.status(404).json({ mensagem: 'Usuário não encontrado', nome });
        }
    })
})
//rodar api
app.listen(PORTA, () => {
    console.log(`Servidor iniciado na porta ${PORTA}`);
  });

module.exports = router;