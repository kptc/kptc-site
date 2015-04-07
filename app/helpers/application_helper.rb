module ApplicationHelper
  
  def show_errors(object, field_name)
    if object.errors.any?
      if !object.errors.messages[field_name].blank?
        raw('<div class="field_with_errors">
          <span class="help-block">' +
            object.errors.messages[field_name].join("<br />") +
          '</span>
          </div>'
        )
      end
    end
  end
  
end
