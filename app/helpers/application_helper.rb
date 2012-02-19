module ApplicationHelper
  def class_for_alert(name)
    case name 
    when :notice
      "alert-success"
    when :alert
      "alert-error"
    when :warning
      "alert-info"
    end
  end
end
