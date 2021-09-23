//= require active_admin/base
//= require activeadmin_addons/all
//= require activeadmin-sortable
//= require editor.md/editormd
//= require editor.md/languages/en


$(() => {
  var $el;
  $('.md .editor').each(() => {
    editormd(this.id, {
      width: "100%",
      height: "1000px",
      path: '/vendor-assets/editor.md/lib/'
    });
  });
  // edit hour page automaticly set the default rate
  $("#hour_project_id").on('change', () => {
    var mapping;
    mapping = $(this).data('rate');
    $("#hour_rate_id").val(mapping[$(this).val()]).trigger('change');
  });
  $el = $('body');
  $('input, select', $el).on('change', () => {
    $('[data-conditional]').each(() => {
      var field, field_value, operator, value;
      [field, operator, value] = $(this).data('conditional').split(' ');
      field_value = $(`[name='${field}']`, $el).val();
      $(this).toggle(eval(`'${field_value}' ${operator} ${value}`));
    });
  }).trigger('change');
});
