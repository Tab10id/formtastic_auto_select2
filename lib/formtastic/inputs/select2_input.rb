class Formtastic::Inputs::Select2Input < Formtastic::Inputs::SelectInput
  extend ActiveSupport::Autoload

  def input_html_options
    input_options = super
    input_options[:class] = [input_options[:class], 'auto-static-select2'].compact.join(' ')
    input_options[:data] ||= {}
    input_options[:data][:placeholder] ||= (options[:placeholder] || localized_label || humanized_method_name)
    input_options
  end
end