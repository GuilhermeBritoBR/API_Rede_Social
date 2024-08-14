import AsyncStorage from "@react-native-async-storage/async-storage";
//salvar nome do usuario
const SaveName = async (name) =>{
    try{
        await AsyncStorage.setItem('@name', name);
    }catch(err){
        console.log(`Erro no salvamento do tolken, segue o erro: ${err}`);
    }
}
export {SaveName};