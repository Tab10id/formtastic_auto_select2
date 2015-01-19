class AjaxSelect2Input < Formtastic::Inputs::StringInput
  extend ActiveSupport::Autoload

  def input_html_options
    url_params = {}
    url_params[:class_name] = options[:search_class] if options[:search_class].present?
    url_params[:search_method] = options[:search_method] if options[:search_method].present?
    url_params[:default_class_name] = options[:default_class_name] if options[:default_class_name].present?
    url_params[:default_text_column] = options[:default_text_column] if options[:default_text_column].present?
    url_params[:default_id_column] = options[:default_id_column] if options[:default_id_column].present?
    url_params[:select2_options] = options[:select2_options] if options[:select2_options].present?
    href = template.select2_autocompletes_path(url_params)
    input_options = {
        value: value
    }.merge(extra_input_html_options).merge(super)
    input_options[:data] = input_options[:data].to_h.merge({
        href: href,
        s2options: url_params[:select2_options].to_h.merge(multiple: multiple?)
    })
    css_classes = [input_options[:class], 'auto-ajax-select2', 'input-hol']
    if multiple?
      css_classes << 'multiple'
    end
    input_options[:class] = css_classes.compact.join(' ')
    input_options
  end

  def extra_input_html_options
    {
        name: input_html_options_name
    }
  end

  def multiple?
    multiple_by_options? || multiple_by_association?
  end

  def value
    val = object.send(association_primary_key)
    val.is_a?(Array) ? val.join(',') : val
  end

  def input_html_options_name
    if builder.options.key?(:index)
      "#{object_name}[#{builder.options[:index]}][#{association_primary_key}]"
    else
      "#{object_name}[#{association_primary_key}]"
    end
  end

  def multiple_by_association?
    reflection && [ :has_many, :has_and_belongs_to_many ].include?(reflection.macro)
  end

  def multiple_by_options?
    options[:multiple] || (options[:input_html] && options[:input_html][:multiple])
  end
end