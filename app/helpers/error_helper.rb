module ErrorHelper

  # Return proper css class for form field
  def field_class(model, field)
    return 'form-group has-error' if model.errors.get(field)
    return 'form-group'
  end

  def render_error_message(model, field)
    if model.errors.get(field)
      content_tag :div, class: 'error_field' do
        model.errors.full_messages_for(field).first
      end
    end
  end
end