module ApplicationHelper

	require 'string'

	#Return a link for use in layout navigation.
	def nav_link(text, action="index", controller)
		return link_to_unless_current text, :id => nil, :controller => controller, :action => action
	end

	def logged_in?
		not session[:user_id].nil?
	end

	def text_field_for(form, field, size=HTML_TEXT_FIELD_SIZE, maxlength=DB_STRING_MAX_LENGTH)
		label = content_tag( :label, "#{field.humanize}:", :for => field)
		form_field = form.text_field field, :size => size, :maxlength => maxlength
		content_tag("div",  label + form_field, :class => "form_row" )

		
		#content_tag( :div, content_tag(:label, "#{field.humanize}: ", :for => field), :class => "form_row" )
		#content_tag("div", "#{label} #{form_field}", :class => "form_row" )
	end

end
