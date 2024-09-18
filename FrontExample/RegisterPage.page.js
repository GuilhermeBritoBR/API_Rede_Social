import { StatusBar } from "expo-status-bar";
import {
  StyleSheet,
  Text,
  View,
  TextInput,
  TouchableOpacity,
} from "react-native";
//importando hooks
import { useState } from "react";
//importar axios para a conexão dos dados ds
import axios from "axios";
//scripts para o funcionamento da aplicação
import { SalvarToken } from "./scripts/SaveToken.script";
//salvar nome
import { SaveName } from "./scripts/SaveName.script";
import AsyncStorage from "@react-native-async-storage/async-storage";

export default function RegisterPage() {
  //variaveis afim de realizar a validação
  const [email, setEmail] = useState("");
  const [nome, setNome] = useState("");
  //senha
  const [senha, setSenha] = useState("");

 
  return (
    <View style={styles.container}>
      <View style={{ flex: 1 }}>
        <Text>Cadastro</Text>
        <StatusBar style="auto" />
        <TextInput
          onChangeText={(email) => setEmail(email)}
          placeholder="Email"
          style={styles.input}
          value={email}
        />
        <TextInput
          onChangeText={(nome) => setNome(nome)}
          placeholder="Password"
          style={styles.input}
          value={nome}
        />
        <TextInput
          onChangeText={(senha) => setSenha(senha)}
          placeholder="Password"
          style={styles.input}
          value={senha}
        />
        <TouchableOpacity
          style={styles.input}
          onPress={() => postarPublicacao()}
        >
          <Text>Entrar</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#fff",
    alignItems: "center",
    justifyContent: "center",
  },
  input: {
    width: 120,
    height: 45,
    border: "solid",
    borderColor: "#000000",
    borderWidth: 1,
  },
});
