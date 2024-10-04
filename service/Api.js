const express = require('express');
const session = require('express-session');
const parser = require('body-parser');
const MySql = require('mysql');
const cors = require('cors');
const multer = require('multer');
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
var posts = "postagens";
//variavel DB do mysql

//componentes


const db = MySql.createConnection({
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': `MovieMaster`
})
//cors
app.use(cors({
    origin: 'http://localhost:8081', // Substitua pela origem do seu frontend
    methods: ['GET', 'PUT', 'POST', 'DELETE'], // Métodos permitidos
    allowedHeaders: ['Content-Type', 'Authorization'] // Cabeçalhos permitidos
}));
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
//upload das fotos
 const storage = multer.diskStorage({
     destination: (req, file, cb) => {
       cb(null, 'uploads/'); // Pasta onde as imagens serão salvas
     },
     filename: (req, file, cb) => {
       const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
       cb(null, uniqueSuffix + path.extname(file.originalname)); // Renomeia o arquivo
     }
   });
  
  // Inicializa o multer com a configuração de armazenamento
  const upload = multer({ storage });   
  
  // Rota para upload de imagem
  app.post('/EnvioDaFoto', upload.single('image'), (req, res) => {
     if (!req.file) {
       return res.status(400).send('Nenhuma imagem foi enviada.');
     }
     res.send(`Imagem salva com sucesso: ${req.file.path}`);
   
  });

//Cadastro dos dados
app.post('/registerPage/cadastro',(req,res)=>{
    //coletando nome e senha
    const {nome,email, senha}= req.body;
    const caminhoFoto = req.file ? req.file.path : null;
    //verificando valor destas
    console.log(`Respectivamente as variaveis: ${nome,email, senha}`);
    //variavel com comando SLQ para inserir dados na tabela credenciais
    const InserirDadosSQL = `INSERT INTO ${nomeDaTabela} (nome, email, senha, foto) VALUES (?,?,SHA2(?, 256),?)`;
    //salvar esses dados em um banco de dados próprio do usuário
    db.query(InserirDadosSQL,[nome,email,senha, caminhoFoto],(err,resposta)=>{
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
// funções de rede social
app.post('/Amigos/PostarPublicacao', VerifyToken ,(req,res)=>{
    const idDoUsuario = req.user.id;
    const { conteudoDaPublicacao, filmeID, dataDaPublicacao, nota, favorito, autor, tituloDoFilme, likesDaPostagem, capaDoFilme } = req.body;

    const InserirPublicacaoSQL = `INSERT INTO ${posts} (credenciais_id, filme_id, texto, data_postagem, nota, favorito, autor,tituloDoFilme,  likesDaPostagem, capaDoFilme) VALUES (?,?,?, ?, ?, ? ,? ,?,?,? )`;

    db.query(InserirPublicacaoSQL,[idDoUsuario, filmeID, conteudoDaPublicacao, dataDaPublicacao, nota, favorito, autor, tituloDoFilme, likesDaPostagem, capaDoFilme ],(err,resultado)=>{
        if (err) {
            console.error('Erro ao inserir publicação:', err);
            return res.status(500).json({ message: 'Erro ao inserir publicação' });
        }
            res.json({ message: resultado });
        
    })
});
//edição do post
//receber dados
app.put('/Amigos/EditarPublicacao', VerifyToken ,(req,res)=>{
    const idDoUsuario = req.user.id;
    const {id_do_post, conteudoDaPublicacao, filmeID, dataDaPublicacao, nota, favorito } = req.body;
        const atualizarPublicacaoSQL = `UPDATE ${posts} SET texto = ?, filme_id = ?, data_postagem = ?, nota = ?, favorito = ? WHERE id = ?`;
        
        db.query(atualizarPublicacaoSQL, [conteudoDaPublicacao, filmeID, dataDaPublicacao,nota, favorito,  id_do_post ], (err) => {
            if (err) {
                console.error('Erro ao atualizar publicação:', err);
                return res.status(500).json({ message: 'Erro ao atualizar publicação' });
            }
            res.json({ message: 'Publicação atualizada com sucesso!' });
})
});
app.get('/Amigos/ReceberPublicacao', VerifyToken, (req,res)=>{
    const idDoUsuario = req.user.id;

    const buscarPublicacaoSQL = `SELECT * FROM ${posts} WHERE credenciais_id = ? `;
    //AND texto = ? AND filme_id = ? AND data_postagem = ?
    db.query(buscarPublicacaoSQL, [idDoUsuario], (err, resultados) => {
        if (err) {
            console.error('Erro ao buscar publicações:', err);
            return res.status(500).json({ message: 'Erro ao buscar publicações' });
        }
        const buscarNomeSQL = `SELECT * FROM ${nomeDaTabela} WHERE id = ? `;
        db.query(buscarNomeSQL,[idDoUsuario],(erroSegundaConsulta, resultadoNomeDoUsuario)=>{
            if (erroSegundaConsulta) {
                console.error('Erro ao buscar nome:', erroSegundaConsulta);
                return res.status(500).json({ message: 'Erro ao buscar publicações' });
            }
            const publicacoesComNome = resultados.map(publicacao => ({
                ...publicacao,
                nomeDoUsuario: resultadoNomeDoUsuario[0]?.nome // Adiciona o nome do usuário
            }));

            res.json(publicacoesComNome);
        })
        
    });
});
app.get('/Amigos/ReceberPublicacaoDosAmigos/:id', VerifyToken, (req,res)=>{
    const id = req.params.id;
    const buscarPublicacaoSQL = `SELECT * FROM ${posts} WHERE credenciais_id = ? `;
    //AND texto = ? AND filme_id = ? AND data_postagem = ?
    db.query(buscarPublicacaoSQL, [id], (err, resultados) => {
        if (err) {
            console.error('Erro ao buscar publicações:', err);
            return res.status(500).json({ message: 'Erro ao buscar publicações' });
        }
        const buscarNomeSQL = `SELECT * FROM ${nomeDaTabela} WHERE id = ? `;
        db.query(buscarNomeSQL,[id],(erroSegundaConsulta, resultadoNomeDoUsuario)=>{
            if (erroSegundaConsulta) {
                console.error('Erro ao buscar nome:', erroSegundaConsulta);
                return res.status(500).json({ message: 'Erro ao buscar publicações' });
            }
            const publicacoesComNome = resultados.map(publicacao => ({
                ...publicacao,
                nomeDoUsuario: resultadoNomeDoUsuario[0]?.nome // Adiciona o nome do usuário
            }));

            res.json(publicacoesComNome);
        })
        
    });
});
//deletar post
app.delete('/Amigos/DeletarPublicacao/:id', VerifyToken, (req,res)=>{
    const id = req.params.id; 
    const DeletarPostSQL = `DELETE FROM ${posts} WHERE id = ?`;
    db.query(DeletarPostSQL,[id],(err)=>{
        if (err) {
            console.log(`Segue o erro: ${err}`);
            return res.status(500).json({ message: 'Erro ao excluir a publicação' });
        }
        
        return res.json({ message: 'Publicação excluída com sucesso!' });
    })


})
//rodar api

//funções de pesquisa
app.get('/PesquisarNomesDeUsuarios', VerifyToken, (req,res)=>{
    const { nome } = req.query;
  db.query(`SELECT * FROM ${nomeDaTabela} WHERE nome LIKE ?`, [`%${nome}%`], (err, results) => {
    if (err) return res.status(500).json(err);
    res.json(results); 
  });
});
  app.get('/Perfil/BuscarMeusFilmesFavoritos', VerifyToken, (req,res)=>{
    const id = req.user.id;
    const comandoParaBuscar = `SELECT * FROM postagens WHERE favorito = 1 AND credenciais_id = ?`;
    db.query(comandoParaBuscar,[id],(err,resposta)=>{
        if(err){
            console.log(`Segue o erro: ${err}`);
            return res.status(500).json({ message: 'Erro ao buscar favoritos' });
        }
        //filme_id, capaDoFilme, tituloDoFilme 
        return res.json({ mensagem: 'Dados coletados com sucesso', resposta });

    })
  });
  app.get('/Pesquisa/BuscarFilmesFavoritosDosAmigos/:id', VerifyToken, (req,res)=>{
    const id = req.params.id;
    const comandoParaBuscar = `SELECT * FROM postagens WHERE favorito = 1 AND credenciais_id = ?`;
    db.query(comandoParaBuscar,[id],(err,resposta)=>{
        if(err){
            console.log(`Segue o erro: ${err}`);
            return res.status(500).json({ message: 'Erro ao buscar favoritos' });
        }
        //filme_id, capaDoFilme, tituloDoFilme 
        return res.json({ mensagem: 'Dados coletados com sucesso', resposta });

    })
  });
//adicionar amigo
app.put('/Amigos/AdicionarAmigo',VerifyToken,(req,res)=>{
    const {id_amigo} = req.body;
    const id = req.user.id;
    const checkSql = `SELECT amigos FROM amigos WHERE credenciais_id = ?`;
    db.query(checkSql, [id], (err, resultados) => {
        if (err) {
            console.log(`Erro ao verificar amigos: ${err}`);
            return res.status(500).json({ message: 'Erro ao verificar amigos' });
        }

        // Se não houver amigos, adicione o novo amigo
        if (resultados.length === 0 || resultados[0].amigos === null) {
            const sql = `INSERT INTO amigos (credenciais_id, amigos) VALUES (?, JSON_ARRAY(?))`;
            db.query(sql, [id, id_amigo], (err, resposta) => {
                if (err) {
                    console.log(`Erro ao adicionar amigo: ${err}`);
                    return res.status(500).json({ message: 'Erro ao adicionar amigo' });
                }

                return res.json({ mensagem: 'Amigo adicionado' });
            });
        } else {
            // Se já houver amigos, apenas adicione o novo amigo à lista
            const sql = `UPDATE amigos SET amigos = JSON_ARRAY_APPEND(amigos, '$', ?) WHERE credenciais_id = ?`;
            db.query(sql, [id_amigo, id], (err, resposta) => {
                if (err) {
                    console.log(`Erro ao adicionar amigo: ${err}`);
                    return res.status(500).json({ message: 'Erro ao adicionar amigo' });
                }

                return res.json({ mensagem: 'Amigo adicionado' });
            });
        }
    });
});

//remover amigo
app.put('/Amigos/RemoverAmigo', VerifyToken, (req, res) => {
    const { id_amigo } = req.body;
    const id = req.user.id;
    const checkSql = `SELECT amigos FROM amigos WHERE credenciais_id = ?`;

    db.query(checkSql, [id], (err, resultados) => {
        if (err) {
            console.log(`Erro ao verificar amigos: ${err}`);
            return res.status(500).json({ message: 'Erro ao verificar amigos' });
        }

        if (resultados.length === 0 || resultados[0].amigos === null) {
            return res.status(400).json({ message: 'Nenhum amigo encontrado para remover' });
        } else {
            const amigos = JSON.parse(resultados[0].amigos);

            // Verifica se o amigo está na lista
            if (!amigos.includes(id_amigo)) {
                return res.status(400).json({ message: 'Amigo não encontrado na lista' });
            }

            // Remove o amigo da lista
            const novosAmigos = amigos.filter(amigo => amigo !== id_amigo);

            const sql = `UPDATE amigos SET amigos = ? WHERE credenciais_id = ?`;
            db.query(sql, [JSON.stringify(novosAmigos), id], (err, resposta) => {
                if (err) {
                    console.log(`Erro ao remover amigo: ${err}`);
                    return res.status(500).json({ message: 'Erro ao remover amigo' });
                }

                return res.json({ message: 'Amigo removido com sucesso' });
            });
        }
    });
});
//verificas amigos
app.get('/Amigos/VerificarAmigos', VerifyToken, (req, res) => {
    const id = req.user.id;
    const sql = `SELECT * FROM amigos WHERE credenciais_id = ?`;

    db.query(sql, [id], (err, resultados) => {
        if (err) {
            console.log(`Erro ao buscar amigos: ${err}`);
            return res.status(500).json({ message: 'Erro ao buscar amigos' });
        }

        if (resultados.length === 0 || resultados[0].amigos === null) {
            return res.json({ amigos: [] }); // Retorna uma lista vazia se não houver amigos
        } else {
            const amigos = JSON.parse(resultados[0].amigos);
            return res.json({ amigos });
        }
    });
});



app.listen(PORTA, () => {
    console.log(`Servidor iniciado na porta ${PORTA}`);
  });

module.exports = router;