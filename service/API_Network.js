//Obs: Esta aplicação refere-se as funções de rede social da aplicação
const express = require('express');
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

//NOME DA TABELA PARA INSERIR DADOS DE USUARIO
var posts = "postagens";
//tabela
const NomeDaTabela = "posts";
const db = MySql.createConnection({
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': `MovieMaster`
})
const PublicarPost = (req, res) => {
    const idDoUsuario = req.user.id;
    const { conteudoDaPublicacao, filmeID, dataDaPublicacao } = req.body;

    const InserirPublicacaoSQL = `INSERT INTO ${posts} (credenciais_id, filme_id, texto, data_postagem) VALUES (?, ? ,? ,? )`;

    db.query(InserirPublicacaoSQL,[idDoUsuario, filmeID, conteudoDaPublicacao, dataDaPublicacao ],(err,resultado)=>{
        if (err) {
            console.error('Erro ao inserir publicação:', err);
            return res.status(500).json({ message: 'Erro ao inserir publicação' });
        }

        res.status(201).json({
            id,
            dataDaPublicacao,
            nomeDoUsuario,
            conteudoDaPublicacao,
            filmeID,
            resultado 
    })
    })
};

module.exports = { PublicarPost };
