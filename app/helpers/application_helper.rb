module ApplicationHelper
  def authenticate_action
    <<-HTML.html_safe
      <input type="hidden"
            name="authenticity_token"
            value="#{form_authenticity_token}">
    HTML
  end

  def method_action(method)
    <<-HTML.html_safe
      <input type="hidden" name="_method" value="#{method}">
    HTML
  end

end
