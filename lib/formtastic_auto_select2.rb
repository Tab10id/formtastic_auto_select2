require 'formtastic_auto_select2/version'
require 'formtastic_auto_select2/engine'
require 'formtastic_auto_select2/infectors'
Formtastic::Inputs.send(:include, FormtasticAutoSelect2::Infectors::Formtastic::Inputs)

module FormtasticAutoSelect2
  extend ActiveSupport::Autoload
end