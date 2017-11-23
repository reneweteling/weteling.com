import React from 'react'
import { View, Text, Image, ScrollView, Button} from 'react-native'
import { MainStyle, ButtonStyle } from '../style'




import { Field, reduxForm, values } from 'redux-form';
import Input from './input';

const projects = [
  {
    value: 1,
    label: 'Weteling.com - app'
  },
  {
    value: 2,
    label: 'Horyon - process app'
  }
]

const rates = [
  {
    value: 1,
    label: 'Normaal - 75'
  },
  {
    value: 2,
    label: 'Dagstaffel - 62,5'
  }
]


class HourForm extends React.Component {
  render(){
    
    return (
      <ScrollView keyboardShouldPersistTaps={'handled'} style={{
        padding: 8
      }}>
      <Field
        label={'Project'}
        name={'project_id'}
        type={'select'}
        collection={projects}
        component={Input}
      />
      <Field
        label={'Rate'}
        name={'rate_id'}
        type={'select'}
        collection={rates}
        component={Input}
      />
      <Field
        label={'Date'}
        name={'date'}
        type={'date'}
        component={Input}
      />
      <Field
        label={'Total hours'}
        name={'total_hours'}
        type={'decimal'}
        component={Input}
      />
      <Field
        label={'Description'}
        name={'description'}
        type={'textarea'}
        collection={projects}
        component={Input}
      />
      <Button
        onPress={this.props.handleSubmit(this.props.onSubmit)}
        title="Add"
        color="#841584"
        accessibilityLabel="Learn more about this purple button"
      />
      </ScrollView>
    )
  }
}

HourForm = reduxForm({
  form: 'hour'
})(HourForm)

export default class HourEdit extends React.Component {
  static navigationOptions = {
    tabBarLabel: 'Add',
    tabBarIcon: ({ tintColor }) => (
      <Image
        source={require('../images/add.png')} 
        style={[ButtonStyle.icon, {tintColor: ButtonStyle.icon.tintColor}]}
      />
    ),
  };

  onSubmit(values){
    console.log(values)
  }

  render() {
    return (
      <View style={{
        marginTop: 20,
        marginBottom: 50

      }}>
        <HourForm ref={(c) => this.refs.c = c}  onSubmit={this.onSubmit}/>
      </View>
    );
  }
}