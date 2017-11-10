import React from 'react';
import IconStyle from '../style/IconStyle'
import { StyleSheet, Text, Image, TextInput, TouchableOpacity, View } from 'react-native'
import { Field, reduxForm } from 'redux-form'

const renderInput = ({ input: { onChange, ...restInput }}) => {
  return <TextInput style={styles.input} onChangeText={onChange} {...restInput} />
}

let ContactForm = props => {
  const { handleSubmit } = props
  
  console.log( props.store )

  return (
    
    <View>
      <Text>Email:</Text>
      <Field name="email" component={renderInput} store={props.store} />
      <TouchableOpacity onPress={handleSubmit}>
        <Text style={styles.button} >Submit</Text>
      </TouchableOpacity>
    </View>
  )
}

const styles = StyleSheet.create({
  button: {
    backgroundColor: 'blue',
    color: 'white',
    height: 30,
    lineHeight: 30,
    marginTop: 10,
    textAlign: 'center',
    width: 250
  },
  container: {

  },
  input: {
    borderColor: 'black',
    borderWidth: 1,
    height: 37,
    width: 250
  }
})

// create new, "configured" function
let createReduxForm = reduxForm({ form: 'contact' })

// evaluate it for ContactForm component
ContactForm = createReduxForm( ContactForm )

console.log(ContactForm)


export default class HourEdit extends React.Component {
  static navigationOptions = {
    tabBarLabel: 'Home',
    // Note: By default the icon is only shown on iOS. Search the showIcon option below.
    tabBarIcon: ({ tintColor }) => (
      <Image
        source={require('../assets/images/icons/Add.png')} 
        style={[IconStyle.icon, {tintColor: tintColor}]}
      />
    ),
  };

  submit = (values) => {
    console.log(values)
  }

  render() {
    return (
      <View>
         <ContactForm {...this.props} onSubmit={this.submit} />
      </View>
    );
  }
}


