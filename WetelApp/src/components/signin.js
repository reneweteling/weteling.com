import React from 'react'
import { View, Text, Button } from 'react-native'
import { MainStyle } from '../style'
import { SIGNED_IN } from './../reducers';
import { connect } from 'react-redux';


export default connect()(class Signin extends React.Component {
  signIn(){ 
    this.props.dispatch({type: SIGNED_IN})
  }
  render() {
    return (
      <View style={MainStyle.container}>
        <Text style={MainStyle.welcome}> 
          Login page
        </Text>

        <Button
            onPress={this.signIn.bind(this)}
            title="Sign in"
            color="#841584"
            accessibilityLabel="Learn more about this purple button"
          />
        

      </View>
    );
  }
})