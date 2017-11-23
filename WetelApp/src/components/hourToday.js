import React from 'react'
import { View, Text, Image } from 'react-native'
import { MainStyle, ButtonStyle } from '../style'

export default class HourToday extends React.Component {
  static navigationOptions = {
    tabBarLabel: 'Today',
    tabBarIcon: ({ tintColor }) => (
      <Image
        source={require('../images/today.png')} 
        style={[ButtonStyle.icon, {tintColor: ButtonStyle.icon.tintColor}]}
      />
    ),
  };
  render() {
    return (
      <View style={MainStyle.container}>
        <Text style={MainStyle.welcome}>
          Hour Todayyy 
        </Text>
      </View>
    );
  }
}
