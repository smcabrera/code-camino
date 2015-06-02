module ApplicationHelper
  def full_title(title = nil)
    if title
      "#{title} | #{app_name}"
    else
      app_name
    end
  end

  def bootstrap_flash(key)
    {"notice" => "success", "error" => "danger", "alert" => "warning"}.fetch(key)
  end

  def app_name
    "Code Camino"
  end

  def company_name
    "Stephen Mariano Cabrera"
  end

  def error_message
    %Q{
      <div class='alert alert-danger'>
        #{flash}
      </div>
    }
  end
end
