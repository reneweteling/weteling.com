import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View, 
  ScrollView, Button
} from 'react-native';

import { Provider, connect } from 'react-redux'
import { createStore } from 'redux'

import { TabNavigator, DrawerNavigator } from 'react-navigation' ;
import { DrawerItems, SafeAreaView } from 'react-navigation';

import { composeWithDevTools } from 'redux-devtools-extension';
import { main } from './style'
import { rootReducer, SIGNED_IN, SIGN_IN, SIGN_OUT, ADD_HOUR } from './reducers';
import Signin from './components/signin'
import HourToday from './components/hourToday'
import HourEdit from './components/hourEdit'
import HourList from './components/hourList'


const store = createStore(
  rootReducer, 
  composeWithDevTools()
)

while( (size = store.getState().hours.length) < 30){
  store.dispatch({type: ADD_HOUR, hour: {
    id: size + 1,
    project_id: 1,
    rate_id: 1,
    date: `2017-01-${size + 1}`,
    total_hours: 5.5,
    description: 'Done this and that'
  }})
}

// mock signin
setTimeout(() => {
  store.dispatch({type: SIGNED_IN})
}, 500)

// the tabs
const Tabs = TabNavigator({
  Add: {
    screen: HourEdit,
  },
  List: {
    screen: HourList,
  }, 
  Today: {
    screen: HourToday,
  },
}, {
  tabBarPosition: 'bottom',
  animationEnabled: true,
  tabBarOptions: {  
    activeTintColor: '#e91e63',
    labelStyle: {
      fontSize: 12,
    },
    style: {
      // backgroundColor: 'blue',
    },
  }
  
})

// the drawer

class CustomDrawerContentComponent extends React.Component {
  signOut(){
    store.dispatch({type: SIGN_OUT})
  }
  render(){
    return (
      <ScrollView>
        <SafeAreaView forceInset={{ top: 'always', horizontal: 'never' }}>
          <Button
            onPress={this.signOut}
            title="Sign out"
            color="#841584"
            accessibilityLabel="Learn more about this purple button"
          />
        </SafeAreaView>
      </ScrollView>
    )
  }
}
 
const Drawer = DrawerNavigator({ 
  Home: {
    screen: Tabs, 
  }
}, {
  contentComponent: CustomDrawerContentComponent
});

class Appie extends React.Component {
  render(){
    if(this.props.user){
      return(
        <Drawer />
      )
    }else{
      return(
        <Signin />
      )
    }
  }
}

const mapStateToProps = state => {
  return {
    user: state.user
  }
}
const mapDispatchToProps = dispatch => {
  return {}
}

const Appie2 = connect(
  mapStateToProps,
  mapDispatchToProps
)(Appie)

export default class App extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <Appie2 />
      </Provider>
    );
  }
}