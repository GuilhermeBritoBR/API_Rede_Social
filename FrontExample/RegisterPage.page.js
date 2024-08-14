import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View, TextInput, TouchableOpacity } from 'react-native';
//importando hooks
import { useState } from 'react';
//importar axios para a conexão dos dados
import axios from 'axios';
//scripts para o funcionamento da aplicação
import { SalvarToken } from './scripts/SaveToken.script';
//salvar nome
import { SaveName } from './scripts/SaveName.script';


export default function RegisterPage() {
  //variaveis afim de realizar a validação
  const [email, setEmail] = useState("");
  const [nome, setNome] = useState("")
  //senha
  const [senha, setSenha] = useState("");

  const salvarDadosEnviarParaOBanco = async ()=>{
    //testando os valores
    alert(`Recebendo os valores para o envio até a API. Email: ${email} Senha:${senha} Nome ${nome}`);
    //jsonficando os valores 
    const dadosEmJsonParaEnvio = {
      nome,email, senha
    };
    try{
      //enviando dados e obtendo resposta
      const respostaRecebida = await axios.post("http://localhost:3000/registerPage/cadastro", dadosEmJsonParaEnvio);
      //coletando informações da resposta
      const {token,nome} = respostaRecebida.data;
      //salva token
      await SalvarToken(token);
      await SaveName(nome);
      alert("Cadastro realizado com sucesso!");

    }catch(err){
      console.log(`Erro ao enviar dados de cadastro, segue o erro: ${err}`);
    }
  }
  return (
    <View style={styles.container}>
      <View style={{flex: 1}}>
      <Text>Cadastro</Text>
      <StatusBar style="auto" />
      <TextInput onChangeText={(email)=>setEmail(email)} placeholder='Email' style={styles.input} value={email}/>
      <TextInput onChangeText={(nome)=> setNome(nome)} placeholder='Password' style={styles.input} value={nome}/>
      <TextInput onChangeText={(senha)=> setSenha(senha)} placeholder='Password' style={styles.input} value={senha}/>
    <TouchableOpacity style={styles.input} onPress={()=>salvarDadosEnviarParaOBanco()}>
      <Text>Entrar</Text>
    </TouchableOpacity>
    </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  input:{
    width: 120,
    height: 45,
    border: 'solid',
    borderColor: '#000000',
    borderWidth: 1,
  },
});
