//Obs: Esta aplicação refere-se as funções de rede social da aplicação
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
const PORTA = 4000;
//criar conexão com mysql
//NOME DA TABELA PARA INSERIR DADOS DE USUARIO

app.post('/Amigos/CurtirPublicação',(req,res)=>{
     
});