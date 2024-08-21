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
            const token = jwt.sign({email}, 'secreto', {expiresIn: '30d'});
            //buscando nome
            
            //envio do token mais resposta da API
            res.json({Mensagem: `Cadastro da RegisterPage Realizado com Sucesso!${resposta}`, token});
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
        SELECT nome 
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
        
            //buscar nome
            const nomeResposta = resposta[0].nome;
            
            //token para validação
            const token = jwt.sign({emailEnome}, 'secreto', {expiresIn: '30d'});
            //envio do token mais resposta da API
            res.json({Mensagem: `Login da LoginPage Realizado com Sucesso!${resposta}`,nomeResposta, token});
        
    })
});
//atualizar os dados do usuario 
//atualizar nome
app.get(`/userPage/atualizarNomeDoUsuario/:id`,(req,res)=>{
    //coletando nome
    const {name}= req.body;
});
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
//rodar api
app.listen(PORTA, () => {
    console.log(`Servidor iniciado na porta ${PORTA}`);
  });
module.exports = router;