import { combineReducers } from 'redux';
import { reducer as formReducer } from 'redux-form'

// initiate reducers
export const ADD_HOUR = 'ADD_HOUR'

function hourReducer(state = [], action){
  switch(action.type){
    case ADD_HOUR:
      return [...state, action.hour]
    default:
      return state;
  }
}

export const SIGN_IN = 'SIGN_IN', 
           SIGNED_IN = 'SIGNED_IN', 
            SIGN_OUT = 'SIGN_OUT'

function userReducer(state = null, action){
  switch(action.type){
    case SIGN_IN:
      return state;
    case SIGNED_IN:
      return {
        id: 1,
        name: 'Rene'
      }
    case SIGN_OUT:
      return null
    default:
      return state;
  }
}

// combine reducers
export const rootReducer = combineReducers({
  hours: hourReducer,
  user: userReducer,
  form: formReducer,
})