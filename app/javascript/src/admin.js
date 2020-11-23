// $('#calendar').fullCalendar(
//   events: '/admin/dashboard/cal_events'
//   defaultView: 'agendaWeek'
//   minTime: '09:00:00'
//   maxTime: '20:00:00'
//   height: 260
//   slotDuration: '01:00:00'
//   allDaySlot: false
// );

import fetch from 'fetch'
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin ],
    
    // defaultView: 'agendaWeek',
    // minTime: '09:00:00',
    // maxTime: '20:00:00',
    // height: 260,
    // slotDuration: '01:00:00',
    // allDaySlot: false,
    

    events: function(info, successCallback, failureCallback) {
      fetch('/admin/dashboard/cal_events')
        .then(response => response.json())
        .then(data =>       successCallback(
          Array.prototype.slice.call( // convert to array
            res.getElementsByTagName('event')
          ).map(function(eventEl) {
            return {
              title: eventEl.getAttribute('title'),
              start: eventEl.getAttribute('start')
            }
          })
        ))

      // req.get()
      //   .type('json')
      //   .query({
      //     start: info.start.valueOf(),
      //     end: info.end.valueOf()
      //   })
      //   .end(function(err, res) {
  

  }
});


  calendar.render();
});