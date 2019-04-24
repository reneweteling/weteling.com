#= require active_admin/base
#= require activeadmin_addons/all
#= require activeadmin-sortable
#= require editor.md/editormd
#= require editor.md/languages/en
#= require moment
#= require fullcalendar


$ ->
  $('#calendar').fullCalendar(
    events: '/admin/dashboard/cal_events'
    defaultView: 'agendaWeek'
    minTime: '09:00:00'
    maxTime: '20:00:00'
    height: 250
    slotDuration: '01:00:00'
    allDaySlot: false
  );

  $('.md .editor').each ->
    editormd @.id, {
      width: "100%"
      height: "1000px"
      path: '/vendor-assets/editor.md/lib/'
    }

  # edit hour page automaticly set the default rate
  $("#hour_project_id").change ->
    mapping = $(@).data('rate')
    $("#hour_rate_id")
      .val mapping[$(@).val()] 
      .trigger 'change'

  $el = $('body')
  
  $('input, select', $el)
    .change ->
      $('[data-conditional]').each ->
        [field, operator, value] = $(@).data('conditional').split(' ')
        field_value = $("[name='#{field}']", $el).val()

        $(@).toggle eval("'#{field_value}' #{operator} #{value}")
    .trigger 'change'
