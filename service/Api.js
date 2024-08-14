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
        req.user = user;
        next();
    })

}
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
            //token para validação
            const token = jwt.sign({email}, 'secreto', {expiresIn: '1h'});
            //envio do token mais resposta da API
            res.json({Mensagem: `Cadastro da RegisterPage Realizado com Sucesso!${resposta}`,nome, token});
        }
    })

});
//login do usuário
app.post('/loginPage/login',(req,res)=>{
    //coletando email e senha
    const {emailEnome, senha}= req.body;
    //comando slq para verificar valoress
    const ValidarDadosSQL = `SELECT nome FROM ${nomeDaTabela} WHERE email = ? AND senha = SHA2(?, 256)`;
    //verificar dados do SQL
    db.query(ValidarDadosSQL,[emailEnome,senha],(err,resposta)=>{
        if(err){
            console.log(`Erro Ao verificar Dados na tabela de cadastro na LoginPage, segue o erro: ${err}`);
            return;
        }else{
            //buscar nome
            const name = resposta[0].nome;
            //token para validação
            const token = jwt.sign({emailEnome}, 'secreto', {expiresIn: '1h'});
            //envio do token mais resposta da API
            res.json({Mensagem: `Login da LoginPage Realizado com Sucesso!${resposta}`,name, token});
        }
    })
});
//atualizar os dados do usuario 
//
//atualizar nome
app.get(`/userPage/atualizarNomeDoUsuario/:id`,(req,res)=>{
    //coletando nome
    const {name}= req.body;
});
//rota da homepage
app.get('/homePage', VerifyToken,( req, res)=>{
    res.json({Mensagem: `Acessado a HomePage ROTA GET com sucesso!`})
})
//rodar api
app.listen(PORTA, () => {
    console.log(`Servidor iniciado na porta ${PORTA}`);
  });
module.exports = router;