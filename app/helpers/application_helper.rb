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

  # def active_link(controller_name, controller_action=nil)
  #   if controller_name && controller_action.present?
  #     current_page?(controller: controller_name, action: controller_action) ? 'active': ''
  #   else
  #     current_page?(controller: controller_name) ? 'active': ''
  #   end
  # end
  
end