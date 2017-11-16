#= require active_admin/base
#= require activeadmin_addons/all
#= require activeadmin-sortable
#= require ckeditor/init
#= require editor.md/editormd
#= require editor.md/languages/en


$ ->
  $('.md .editor').each ->
    editormd @.id, {
      width: "100%"
      height: "500px"
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
