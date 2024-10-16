const express = require('express');
const multer = require('multer');
const session = require('express-session');
const parser = require('body-parser');
const MySql = require('mysql');
const cors = require('cors');

//este serve para gerar token do usuario
const jwt = require('jsonwebtoken');
const path = require('path');
const fs = require('fs');
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
var uploadDir = path.join(__dirname, 'uploads');

// Verifica se o diretório de upload existe e cria se não existir
if (!fs.existsSync(uploadDir)) {
    fs.mkdirSync(uploadDir);
}
const db = MySql.createConnection({
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': `MovieMaster`
})
//cors
app.use(cors());
// Usando o middleware para parsear JSON

// Aumentando o limite de tamanho do body-parser
app.use(parser.json({ limit: '100mb' })); // Ajuste o limite conforme necessário
app.use(parser.urlencoded({ limit: '100mb', extended: true }));
// Usando o middleware para parsear dados de formulário

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
app.use('/uploads', express.static('uploads'));

//Cadastro dos dados
app.post('/registerPage/cadastro', (req, res) => {
    // coletando nome, email, senha e foto
    const { nome, email, senha, foto } = req.body;

    if (foto) {
        const fotoBuffer = Buffer.from(foto, 'base64');
        const fotoPath = `uploads/${nome}_foto.jpg`; // Caminho onde a imagem será salva

        // Salva a imagem no servidor
        fs.writeFile(fotoPath, fotoBuffer, (err) => {
            if (err) {
                console.log('Erro ao salvar imagem:', err);
                return res.status(500).json({ error: 'Erro ao salvar imagem' });
            }

            // Caminho completo da imagem
            console.log(`Respectivamente as variáveis: ${nome}, ${email}, ${senha}`);
            // variável com comando SQL para inserir dados na tabela credenciais
            const InserirDadosSQL = `INSERT INTO ${nomeDaTabela} (nome, email, senha, foto) VALUES (?, ?, SHA2(?, 256), ?)`;
            
            // salvar esses dados em um banco de dados próprio do usuário
            db.query(InserirDadosSQL, [nome, email, senha, fotoPath], (err, resposta) => {
                if (err) {
                    console.log(`Erro ao inserir dados na tabela de cadastro na RegisterPage, segue o erro: ${err}`);
                    return res.status(500).json({ error: 'Erro ao inserir dados' });
                } else {
                    // gerando o id automático
                    const id = resposta.insertId;
                    // token para validação
                    const token = jwt.sign({ id, nome }, 'secreto', { expiresIn: '30d' });
                    // envio do token mais resposta da API
                    res.json({ Mensagem: `Cadastro da RegisterPage realizado com sucesso!`, nome, token });
                }
            });
        });
    } else {
        res.status(400).json({ error: 'Foto não fornecida' });
    }
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
    const { nome, email, foto} = req.body;
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
app.get('/Amigos/ReceberPublicacao', VerifyToken, (req, res) => {
    const idDoUsuario = req.user.id;

    const buscarPublicacaoSQL = `SELECT * FROM ${posts} WHERE credenciais_id = ?`;
    db.query(buscarPublicacaoSQL, [idDoUsuario], (err, resultados) => {
        if (err) {
            console.error('Erro ao buscar publicações:', err);
            return res.status(500).json({ message: 'Erro ao buscar publicações' });
        }

        // Se não houver resultados, retorna uma resposta vazia
        if (resultados.length === 0) {
            return res.json({ message: 'Nenhuma publicação encontrada', publicacoes: [] });
        }

        // Para cada publicação, buscar o nome e foto do usuário
        const publicacoesComNomePromises = resultados.map(publicacao => {
            return new Promise((resolve, reject) => {
                const buscarNomeSQL = `SELECT nome, foto FROM ${nomeDaTabela} WHERE id = ?`;
                db.query(buscarNomeSQL, [publicacao.credenciais_id], (erroSegundaConsulta, resultadoNomeDoUsuario) => {
                    if (erroSegundaConsulta) {
                        return reject(erroSegundaConsulta);
                    }
                    if (resultadoNomeDoUsuario.length > 0) {
                        resolve({
                            ...publicacao,
                            nomeDoUsuario: resultadoNomeDoUsuario[0].nome,
                            foto: resultadoNomeDoUsuario[0].foto
                        });
                    } else {
                        resolve({
                            ...publicacao,
                            nomeDoUsuario: 'Usuário Desconhecido',
                            foto: null
                        });
                    }
                });
            });
        });

        // Aguardar todas as promessas de nome serem resolvidas
        Promise.all(publicacoesComNomePromises)
            .then(publicacoesComNome => {
                res.json({ message: 'Publicações encontradas', publicacoes: publicacoesComNome });
            })
            .catch(err => {
                console.error('Erro ao buscar nomes e fotos:', err);
                res.status(500).json({ message: 'Erro ao buscar nomes e fotos dos usuários' });
            });
    });
});
app.get('/Amigos/ReceberPublicacoesDosOutrosPerfils/:id', VerifyToken, (req, res) => {
    const idDoUsuario = req.params.id;  

    const buscarPublicacaoSQL = `SELECT * FROM ${posts} WHERE credenciais_id = ?`;
    db.query(buscarPublicacaoSQL, [idDoUsuario], (err, resultados) => {
        if (err) {
            console.error('Erro ao buscar publicações:', err);
            return res.status(500).json({ message: 'Erro ao buscar publicações' });
        }

        // Se não houver resultados, retorna uma resposta vazia
        if (resultados.length === 0) {
            return res.json({ message: 'Nenhuma publicação encontrada', publicacoes: [] });
        }

        // Para cada publicação, buscar o nome e foto do usuário
        const publicacoesComNomePromises = resultados.map(publicacao => {
            return new Promise((resolve, reject) => {
                const buscarNomeSQL = `SELECT nome, foto FROM ${nomeDaTabela} WHERE id = ?`;
                db.query(buscarNomeSQL, [publicacao.credenciais_id], (erroSegundaConsulta, resultadoNomeDoUsuario) => {
                    if (erroSegundaConsulta) {
                        return reject(erroSegundaConsulta);
                    }
                    if (resultadoNomeDoUsuario.length > 0) {
                        resolve({
                            ...publicacao,
                            nomeDoUsuario: resultadoNomeDoUsuario[0].nome,
                            foto: resultadoNomeDoUsuario[0].foto
                        });
                    } else {
                        resolve({
                            ...publicacao,
                            nomeDoUsuario: 'Usuário Desconhecido',
                            foto: null
                        });
                    }
                });
            });
        });

        // Aguardar todas as promessas de nome serem resolvidas
        Promise.all(publicacoesComNomePromises)
            .then(publicacoesComNome => {
                res.json({ message: 'Publicações encontradas', publicacoes: publicacoesComNome });
            })
            .catch(err => {
                console.error('Erro ao buscar nomes e fotos:', err);
                res.status(500).json({ message: 'Erro ao buscar nomes e fotos dos usuários' });
            });
    });
});


app.get('/Amigos/BuscarPostsDosMeusAmigos', VerifyToken, (req, res) => {
    const id = req.user.id;

    // Primeiro, buscar os amigos
    const sql = `SELECT credenciais_id FROM amigos WHERE JSON_CONTAINS(amigos, ?)`;
    db.query(sql, [JSON.stringify(id)], (err, resposta) => {
        if (err) {
            console.log(`Erro ao buscar amigos: ${err}`);
            return res.status(500).json({ message: 'Erro ao buscar amigos' });
        }

        // Extrai os IDs da resposta
        const ids = resposta.map(row => row.credenciais_id);

        // Se não houver IDs, retorna uma resposta vazia
        if (ids.length === 0) {
            return res.json({ message: 'Sem amigos', publicacoes: [] });
        }

        // Buscar publicações dos amigos
        const buscarPublicacaoSQL = `SELECT * FROM ${posts} WHERE credenciais_id IN (?)`;
        db.query(buscarPublicacaoSQL, [ids], (err, publicacoes) => {
            if (err) {
                console.error('Erro ao buscar publicações:', err);
                return res.status(500).json({ message: 'Erro ao buscar publicações' });
            }

            // Criar uma lista de publicações com os nomes dos usuários
            const publicacoesComNome = [];

            // Para cada publicação, buscar o nome do usuário
            const buscarNomePromises = publicacoes.map(publicacao => {
                return new Promise((resolve, reject) => {
                    const buscarNomeSQL = `SELECT nome, foto FROM ${nomeDaTabela} WHERE id = ?`;
                    db.query(buscarNomeSQL, [publicacao.credenciais_id], (erroSegundaConsulta, resultadoNomeDoUsuario) => {
                        if (erroSegundaConsulta) {
                            return reject(erroSegundaConsulta);
                        }
                        const nome = resultadoNomeDoUsuario[0]?.nome || 'Usuário Desconhecido';
                        const foto = resultadoNomeDoUsuario[0]?.foto || 'Usuário Desconhecido'; // Adiciona nome ou nome padrão
                        publicacoesComNome.push({ ...publicacao, nomeDoUsuario: nome, foto: foto });
                        resolve();
                    });
                });
            });

            // Aguardar todas as promessas de nomes serem resolvidas
            Promise.all(buscarNomePromises)
                .then(() => {
                    res.json({ message: 'Publicações encontradas', publicacoes: publicacoesComNome });
                })
                .catch((erro) => {
                    console.error('Erro ao buscar nomes:', erro);
                    res.status(500).json({ message: 'Erro ao buscar nomes dos usuários' });
                });
        });
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
app.get('/Perfil/BuscarFotoDePerfil', VerifyToken, (req, res) => {
    const id = req.user.id;

    // Consulta ao banco de dados para obter o caminho da foto
    const query = 'SELECT foto FROM credenciais WHERE id = ?';
    db.query(query, [id], (err, results) => {
        if (err) {
            console.error('Erro ao consultar a tabela de credenciais:', err);
            return res.status(500).json({ error: 'Erro ao consultar a tabela de credenciais' });
        }

        if (results.length === 0) {
            return res.status(404).json({ error: 'Usuário não encontrado' });
        }

        const fotoPath = results[0].foto; // Obtém o caminho da foto

        // Retorna a URL da foto em formato JSON
        res.json({ foto: fotoPath });
    });})
    //buscar foto dos amigos
    app.get('/Perfil/BuscarFotoDePerfilDosAmigos/:id', VerifyToken, (req, res) => {
        const id = req.params.id;
    
        // Consulta ao banco de dados para obter o caminho da foto
        const query = 'SELECT foto FROM credenciais WHERE id = ?';
        db.query(query, [id], (err, results) => {
            if (err) {
                console.error('Erro ao consultar a tabela de credenciais:', err);
                return res.status(500).json({ error: 'Erro ao consultar a tabela de credenciais' });
            }
    
            if (results.length === 0) {
                return res.status(404).json({ error: 'Usuário não encontrado' });
            }
    
            const fotoPath = results[0].foto; // Obtém o caminho da foto
    
            // Retorna a URL da foto em formato JSON
            res.json({ foto: fotoPath });
        });})
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
app.get('/Amigos/VerificarAmigos/:id', VerifyToken, (req, res) => {
    const id = req.params.id;
    const sql = `SELECT amigos FROM amigos WHERE credenciais_id = ?`;

    db.query(sql, [id], (err, resultados) => {
        if (err) {
            console.log(`Erro ao buscar amigos: ${err}`);
            return res.status(500).json({ message: 'Erro ao buscar amigos' });
        }

        if (resultados.length === 0 || resultados[0].amigos === null) {
            return res.json({ message: 'Erro ao buscar nomes dos amigos' , amigos: [] }); // Retorna uma lista vazia se não houver amigos
        } else {
            const amigos = JSON.parse(resultados[0].amigos);

            // Se houver amigos, faz uma nova consulta para obter os nomes
            const sqlNomes = `SELECT id, nome, foto FROM credenciais WHERE id IN (?)`;

            db.query(sqlNomes, [amigos], (err, resultadoNomes) => {
                if (err) {
                    console.log(`Erro ao buscar nomes dos amigos: ${err}`);
                    return res.status(500).json({ message: 'Erro ao buscar nomes dos amigos' });
                }

                // Retorna os amigos com seus respectivos nomes
                return res.json({ amigos: resultadoNomes });
            });
        }
    });
});
//amigos meus
app.get('/Amigos/VerificarMeusAmigos', VerifyToken, (req, res) => {
    const id = req.user.id;
    const sql = `SELECT amigos FROM amigos WHERE credenciais_id = ?`;

    db.query(sql, [id], (err, resultados) => {
        if (err) {
            console.log(`Erro ao buscar amigos: ${err}`);
            return res.status(500).json({ message: 'Erro ao buscar amigos' });
        }

        if (resultados.length === 0 || resultados[0].amigos === null) {
            return res.json({ message: 'Erro ao buscar nomes dos amigos' , amigos: [] }); // Retorna uma lista vazia se não houver amigos
        } else {
            const amigos = JSON.parse(resultados[0].amigos);

            // Se houver amigos, faz uma nova consulta para obter os nomes
            const sqlNomes = `SELECT id, nome, foto FROM credenciais WHERE id IN (?)`;

            db.query(sqlNomes, [amigos], (err, resultadoNomes) => {
                if (err) {
                    console.log(`Erro ao buscar nomes dos amigos: ${err}`);
                    return res.status(500).json({ message: 'Erro ao buscar nomes dos amigos' });
                }

                // Retorna os amigos com seus respectivos nomes
                return res.json({ amigos: resultadoNomes });
            });
        }
    });
});
//verificar os meus seguidores
app.get('/Perfil/BuscarOsQueMeSeguem/:id', VerifyToken, (req, res) => {
    const id_params = req.params.id;
    const id_user = req.user.id;
    const sql = `SELECT credenciais_id FROM amigos WHERE JSON_CONTAINS(amigos, ?, '$')`;

    db.query(sql, [(parseInt(id_params) === 0 ? id_user : id_params)], (err, resposta) => {
        if (err) {
            console.log(`Erro ao buscar amigos: ${err}`);
            return res.status(500).json({ message: 'Erro ao buscar amigos' });
        }

        // Extrai os IDs da resposta
        const ids = resposta.map(row => row.credenciais_id);   

        // Se não houver IDs, retorna uma resposta vazia
        if (ids.length === 0) {
            return res.json({ message: 'Sem amigos' ,seguidores: [] });
        }

        const sqlNomes = `SELECT id, nome, foto FROM credenciais WHERE id IN (?)`;
        db.query(sqlNomes, [ids], (err, resultadoNomes) => {
            if (err) {
                console.log(`Erro ao buscar nomes dos amigos: ${err}`);
                return res.status(500).json({ message: 'Erro ao buscar nomes dos amigos' });
            }

            // Retorna os amigos com seus respectivos nomes
            return res.json({message: 'deu certo', seguidores: resultadoNomes });
        });
    });
});
//criar lista de filmes
app.post('/Listas/CriarListaDeFilmes',VerifyToken,(req,res)=>{
    const id = req.user.id;
    const {filmesArray,  lista} = req.body;
    const filmesArrayString = JSON.stringify(filmesArray);
    const sql = `INSERT INTO listas (lista, credenciais_id, nome_lista) VALUES (?, ?, ?)`;
    db.query(sql,[filmesArrayString, id, lista],(err,resposta)=>{
        if(err){
            console.log(`Erro ao criar tabela: ${err}`);
            return res.status(500).json({ message: 'Erro ao criar tabela' }); 
        }
        return res.json({message: 'deu certo' })
    })


});
//dar like
app.post('/Amigos/CurtirReviewDosAmigos',VerifyToken,(req,res)=>{
    const id = req.user.id;
    const {idDoPost} = req.body;
    console.log(`User ID: ${req.user.id}`);
    console.log(`Id do post: ${idDoPost}`);
    const SQL = `INSERT INTO curtidas (credenciais_id, postagens_id) VALUES (?, ?)`;
    db.query(SQL,[id, idDoPost],(err,resposta)=>{
        if (err) {
            console.log(`Erro ao curtir post: ${err}`);
            return res.status(500).json({ message: 'Erro ao curtir post' });
        }
        return res.json({ message: 'Post curtido' });
    })
})
app.get('/Amigos/VerificarCurtirDoPost/:id', VerifyToken, (req, res) => {
    const idUsuario = req.user.id; 
    const  idDoPost  = req.params.id; 

    const SQL = `SELECT * FROM curtidas WHERE credenciais_id = ? AND postagens_id = ?`;
    db.query(SQL, [idUsuario, idDoPost], (err, resultado) => {
        if (err) {
            console.log(`Erro ao verificar curtida: ${err}`);
            return res.status(500).json({ message: 'Erro ao verificar curtida' });
        }
        if (resultado.length > 0) {
            // O usuário curtiu o post
            return res.json({ curtiu: true });
        } else {
            // O usuário não curtiu o post  
            return res.json({ curtiu: false });
        }
    });
});

app.get('/Amigos/QuantidadeDeCurtidasPorPost/:id', VerifyToken, (req, res) => {
    const idDoPost  = req.params.id;

    const SQL = `SELECT COUNT(*) AS totalCurtidas FROM curtidas WHERE postagens_id = ?`;
    db.query(SQL, [idDoPost], (err, resultado) => {
        if (err) {
            console.log(`Erro ao contar curtidas: ${err}`);
            return res.status(500).json({ message: 'Erro ao contar curtidas' });
        }
        return res.json({ totalCurtidas: resultado[0].totalCurtidas });
    });
});
//remover like
app.post('/Amigos/DescurtirReviewDosAmigos', VerifyToken, (req, res) => {
    const { idDoPost } = req.body;
    const userId = req.user.id; // Supomos que o middleware VerifyToken adiciona o id do usuário

    const SQL = `DELETE FROM curtidas WHERE postagens_id = ? AND credenciais_id = ?`;
    
    db.query(SQL, [idDoPost, userId], (err, resultado) => {
        if (err) {
            console.log(`Erro ao descurtir post: ${err}`);
            return res.status(500).json({ message: 'Erro ao descurtir post' });
        }
        return res.json({ message: 'Post descurtido com sucesso' });
    });
});



app.listen(PORTA, () => {
    console.log(`Servidor iniciado na porta ${PORTA}`);
  });

module.exports = router;