module ApplicationHelper
	def language_selector
		if I18n.locale == :en
			link_to "Fracais", url_for(:locale => 'fr')
		else
			link_to "English", url_for(:locale => 'en')
		end
	end
	
	def show_field_error(model, field)
    s=""

    if !model.errors[field].empty?
      s =
        <<-EOHTML
           <div id="error_message">
             #{model.errors[field][0]}
           </div>
        EOHTML
    end

    s.html_safe
  end
end
