//= require active_admin/base
//= require activeadmin_addons/all
//= require activeadmin-sortable


// PWA: install /admin as a standalone app.
(function() {
  if (!document.querySelector('link[rel="manifest"][href="/admin.webmanifest"]')) {
    var link = document.createElement('link');
    link.rel = 'manifest';
    link.href = '/admin.webmanifest';
    document.head.appendChild(link);
  }

  if (!document.querySelector('meta[name="apple-mobile-web-app-capable"]')) {
    var m1 = document.createElement('meta');
    m1.name = 'apple-mobile-web-app-capable';
    m1.content = 'yes';
    document.head.appendChild(m1);

    var m2 = document.createElement('meta');
    m2.name = 'apple-mobile-web-app-title';
    m2.content = 'Admin';
    document.head.appendChild(m2);

    var m3 = document.createElement('meta');
    m3.name = 'theme-color';
    m3.content = '#030712';
    document.head.appendChild(m3);
  }

  if ('serviceWorker' in navigator && (window.location.protocol === 'https:' || window.location.hostname === 'localhost')) {
    window.addEventListener('load', function() {
      navigator.serviceWorker.register('/admin-sw.js', { scope: '/admin' }).catch(function(err) {
        console.warn('Admin SW registration failed:', err);
      });
    });
  }
})();

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
