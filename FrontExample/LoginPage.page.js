import {NavigationContainer} from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';


export default function App() {
  //criar stack
  const Stack = createNativeStackNavigator();
  return (
    <NavigationContainer>
      <Stack.Navigator
      initialRouteName={RegisterPage}
      screenOptions={{
        headerShown:false,
      }}
      >
      {/* ROTAS */}
      <Stack.Screen name="RegisterPage" component={RegisterPage}/>
      </Stack.Navigator>
    </NavigationContainer>
  );
}