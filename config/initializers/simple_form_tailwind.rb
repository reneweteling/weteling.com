# frozen_string_literal: true

SimpleForm.setup do |config|
  config.button_class = 'bg-blue-600 text-white px-6 py-3 rounded-lg hover:bg-blue-700 transition-colors duration-200 font-semibold cursor-pointer'

  config.boolean_label_class = 'inline-flex items-center'

  config.label_text = lambda { |label, required, explicit_label| "#{label} #{required}" }

  config.boolean_style = :inline

  config.item_wrapper_tag = :div

  config.include_default_input_wrapper_class = false

  config.error_notification_class = 'bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded-lg mb-4'

  config.error_method = :to_sentence

  config.input_field_error_class = 'border-red-500'
  config.input_field_valid_class = 'border-green-500'

  config.wrappers :vertical_form, tag: 'div', class: 'mb-4' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'block text-sm font-medium text-gray-700 mb-1'
    b.use :input, class: 'w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-colors', error_class: 'border-red-500', valid_class: 'border-green-500'
    b.use :full_error, wrap_with: { tag: 'p', class: 'mt-1 text-sm text-red-600' }
  end

  config.wrappers :select_form, tag: 'div', class: 'mb-4' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :pattern
    b.optional :readonly
    b.use :label, class: 'block text-sm font-medium text-gray-700 mb-1'
    b.use :input, class: 'w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none', error_class: 'border-red-500', valid_class: 'border-green-500'
    b.use :full_error, wrap_with: { tag: 'p', class: 'mt-1 text-sm text-red-600' }
  end

  config.wrappers :vertical_boolean, tag: 'div', class: 'mb-4 flex items-center' do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: 'h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500'
    b.use :label, class: 'ml-2 text-sm text-gray-700'
  end

  config.wrappers :vertical_file, tag: 'div', class: 'mb-4' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'block text-sm font-medium text-gray-700 mb-1'
    b.use :input, class: 'block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100'
    b.use :full_error, wrap_with: { tag: 'p', class: 'mt-1 text-sm text-red-600' }
  end

  config.wrappers :vertical_multi_select, tag: 'div', class: 'mb-4' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'block text-sm font-medium text-gray-700 mb-1'
    b.use :input, class: 'w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none', error_class: 'border-red-500', valid_class: 'border-green-500'
    b.use :full_error, wrap_with: { tag: 'p', class: 'mt-1 text-sm text-red-600' }
  end

  config.default_wrapper = :vertical_form

  config.wrapper_mappings = {
    boolean:       :vertical_boolean,
    date:          :vertical_multi_select,
    datetime:      :vertical_multi_select,
    file:          :vertical_file,
    time:          :vertical_multi_select,
    select:        :select_form
  }
end
