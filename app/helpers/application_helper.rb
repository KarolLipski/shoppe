module ApplicationHelper

  # Converted flash to toastr message
  def bootstrap_flash
    opts = '<script>var opts = {
	    "closeButton": true,
    };</script>'
    flash_messages = [opts.html_safe]
    flash.each do |type,message|
      type = 'error' if type == 'danger'
      type = 'success' if type == 'success'
      type = 'warning' if type == 'warning'
      text = "<script>$(document).ready( function() {
      toastr.#{type}('#{message}','',opts);
    } );</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end

  def render_date(date)
    date.strftime("%d-%m-%Y  %H:%M:%S")
  end

end
