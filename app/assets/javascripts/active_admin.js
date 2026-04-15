//= require active_admin/base
//= require activeadmin_addons/all
//= require activeadmin-sortable


$(() => {
  // edit hour page: automatically set the default rate when project changes
  $("#hour_project_id").on('change', function() {
    var mapping = $(this).data('rate');
    if (mapping) {
      $("#hour_rate_id").val(mapping[$(this).val()]).trigger('change');
    }
  });

  var $el = $('body');
  $('input, select', $el).on('change', function() {
    $('[data-conditional]').each(function() {
      var [field, operator, value] = $(this).data('conditional').split(' ');
      var field_value = $(`[name='${field}']`, $el).val();
      $(this).toggle(eval(`'${field_value}' ${operator} ${value}`));
    });
  }).trigger('change');
});
