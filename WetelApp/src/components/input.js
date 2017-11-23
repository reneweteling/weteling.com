import React from 'react';
import { TextInput, View, Text, StyleSheet, DatePickerIOS, Picker } from 'react-native';


const inputStyle = {
  borderColor: 'gray',
  borderWidth: StyleSheet.hairlineWidth,
  width: '65%'
}

export default function Input(props) {
  const { input, meta, ...inputProps } = props;

  const formStates = ['active', 'autofilled', 'asyncValidating', 'dirty', 'invalid', 'pristine',
    'submitting', 'touched', 'valid', 'visited'];

  

  const renderInput = () => {
    switch(props.type){
      case 'text':
        return (
          <TextInput
            {...inputProps}
            onChangeText={input.onChange}
            onBlur={input.onBlur}
            onFocus={input.onFocus}
            value={input.value}
            style={inputStyle}
          />
        )
      case 'datee':
        return (
          <DatePickerIOS
            {...inputProps}
            onChangeText={input.onChange}
            onBlur={input.onBlur}
            onFocus={input.onFocus}
            value={input.value}
            style={inputStyle}
          />
        )
      case 'select':
        return (
          <Picker
            {...inputProps}
            onValueChange={input.onChange}
            onBlur={input.onBlur}
            onFocus={input.onFocus}
            selectedValue={input.value}
            style={inputStyle}
          >
          {
            props.collection.map((item, i) => {
              return <Picker.Item key={`${input.name}-item-${i}`} {...item} />
            })
          }
          </Picker>
        )
      case 'textarea':
        return (
          <TextInput
            {...inputProps}
            onChangeText={input.onChange}
            onBlur={input.onBlur}
            onFocus={input.onFocus}
            value={input.value}
            style={inputStyle}
            multiline={true}
          />
        )
      case 'decimal':
        return (
          <TextInput
            {...inputProps}
            onChangeText={input.onChange}
            onBlur={input.onBlur}
            onFocus={input.onFocus}
            value={input.value}
            style={inputStyle}
            keyboardType={'numeric'}
          />
        )
      default:
        return;
    }
  }
  return (
    <View>
      <View style={{
        flex: 1,
        flexDirection: 'row'
      }}>
        <Text style={{
          width: '35%'
        }} >{props.label}</Text>
        {renderInput()}
        
      </View>
        {
          formStates.filter((state) => meta[state]).map((state) => {
            return <Text key={state}> - { state }</Text>;
          })
        }
    </View>
  );
}