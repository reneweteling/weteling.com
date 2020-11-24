import { Calendar } from '@fullcalendar/core';
import timeGridPlugin from '@fullcalendar/timegrid';
import momentPlugin from '@fullcalendar/moment';

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ timeGridPlugin, momentPlugin ],
    timeZone: 'Europe/Amsterdam',
    initialView: 'timeGridWeek',
    slotMinTime: '09:00:00',
    slotMaxTime: '20:00:00',
    allDaySlot: false,
    expandRows: true,
    slotDuration: '01:00:00',
    dayHeaderFormat: "DD-MM",
    slotLabelFormat: "HH:mm",
    events: function({endStr, startStr}, successCallback, _failureCallback) {
      fetch(`/admin/dashboard/cal_events?start=${startStr}&end=${endStr}`)
        .then(response => response.json())
        .then(data => successCallback(data))
    },
  });
  calendar.render()
});