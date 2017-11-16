import React from 'react';
import { TabNavigator } from 'react-navigation' ;
import HourEdit from "./pages/HourEdit";
import HourList from "./pages/HourList";

import { Provider } from 'react-redux';
import { createStore, combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form';
import devToolsEnhancer from 'remote-redux-devtools';

// initiate reducers
const ADD_HOUR = 'ADD_HOUR'

function hourReducer(state = [], action){
  switch(action.type){
    case ADD_HOUR:
      return [
        ...state,
        {
          user: 'rene'
        }
      ]
    default:
      console.log(`Hour action dispatched: ${action.type}`);
      return state;
  }
}

// combine reducers

const rootReducer = combineReducers({
  // ...your other reducers here
  // you have to pass formReducer under 'form' key,
  // for custom keys look up the docs for 'getFormState'
  hours: hourReducer,
  form: formReducer,
})

// create the default store
const store = createStore(rootReducer, devToolsEnhancer())

// initiate tabs
const Tabs = TabNavigator({
  Add: {
    screen: HourEdit,
  },
  List: {
    screen: HourList,
  }, 
}, {
  tabBarPosition: 'bottom',
  animationEnabled: true,
  tabBarOptions: {
    activeTintColor: '#e91e63',
  },
});

// eport default app

export default class Main extends React.Component {
  render() {
    return (
      <Provider store={store}>
        <Tabs />
      </Provider>
    );
  }
}