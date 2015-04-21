module FormtasticAutoSelect2
  module Infectors
    module Formtastic
      module Inputs
        extend ActiveSupport::Concern

        included do
          autoload :Select2Input
          autoload :AjaxSelect2Input
        end
      end
    end
  end
end