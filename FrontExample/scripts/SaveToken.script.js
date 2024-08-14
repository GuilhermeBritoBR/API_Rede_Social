import AsyncStorage from "@react-native-async-storage/async-storage";

const SalvarToken = async (token) =>{
    try{
        await AsyncStorage.setItem('@token', token);
    }catch(err){
        console.log(`Erro no salvamento do tolken, segue o erro: ${err}`);
    }
}
export {SalvarToken};