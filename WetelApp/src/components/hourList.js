import React from 'react'
import { View, Text, Image, FlatList, StyleSheet } from 'react-native'
import { MainStyle, ButtonStyle } from '../style'
import { connect } from 'react-redux';
import moment from 'moment';
import 'moment/locale/nl';

moment.locale('nl');



const mapStateToProps = (state) => {
  return {
    hours: state.hours
  }
}
const mapDispatchToProps = dispatch => {
  return {}
}

export default connect(mapStateToProps, mapDispatchToProps)(class HourList extends React.Component {
  static navigationOptions = {
    tabBarLabel: 'List',
    tabBarIcon: ({ tintColor }) => (
      <Image
        source={require('../images/index.png')} 
        style={[ButtonStyle.icon, {tintColor: ButtonStyle.icon.tintColor}]}
      />
    ),
  };

  renderItem(props){
    const hour = props.item
    // const date = moment(hour.date).format('dd D MMM');     
    const date = hour.date
    
    return (
      <View style={{
        flex: 1,
        flexDirection: 'row',
        // justifyContent: 'space-between',
        top: 5,
        height: 30
        
      }}>
        <Text style={{ width: '5%', left: 5 }}>{hour.id}</Text>
        <Text style={{ width: '5%' }}>{hour.projct_id}</Text>
        <Text style={{ width: '10%' }}>{hour.rate_id}</Text>
        <Text style={{ width: '20%' }}>{date}</Text>
        <Text style={{ width: '10%' }}>{hour.total_hours}</Text>
        <Text style={{ width: '40%' }}>{hour.description}</Text>
      </View>
    )
  }

  renderSeparator(){
    return (
      <View
        style={{
          height: 1,
          // width: "86%",
          backgroundColor: "#CED0CE",
          // marginLeft: "14%"
        }}
      />
    )
  }

  render() {
    return (
      <FlatList
        style={{
          top: 22
        }}
        data={this.props.hours}
        renderItem={this.renderItem}
        ItemSeparatorComponent={this.renderSeparator}
        keyExtractor={item => item.id}
      />  
    );
  }
})

