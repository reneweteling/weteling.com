#= require active_admin/base
#= require activeadmin_addons/all


$ ->
  # edit hour page automaticly set the default rate
  $("#hour_project_id").change ->
    mapping = $(@).data('rate')
    $("#hour_rate_id")
      .val mapping[$(@).val()] 
      .trigger 'change'
