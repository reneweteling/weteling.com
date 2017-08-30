#= require active_admin/base
#= require activeadmin_addons/all
#= require ckeditor/init


$ ->
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
