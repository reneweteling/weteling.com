import React from 'react';
import { Image, Button, StyleSheet, View} from 'react-native';
import IconStyle from '../style/IconStyle'

export default class HourEdit extends React.Component {
  static navigationOptions = {
    tabBarLabel: 'List',
    // Note: By default the icon is only shown on iOS. Search the showIcon option below.
    tabBarIcon: ({ tintColor }) => (
      <Image
        source={require('../assets/images/icons/Bookmarks.png')} 
        style={[IconStyle.icon, {tintColor: tintColor}]}
      />
    ),
  };

  render() {
    return (
      <View>
        <Button
          onPress={() => this.props.navigation.navigate('Notifications')}
          title="Go to notifications"
        />
      </View>
    );
  }
}


