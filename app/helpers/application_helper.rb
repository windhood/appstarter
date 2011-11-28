module ApplicationHelper
  def body_classes
    "#{params[:controller]} #{params[:controller]}_#{params[:action]}"
  end
  
  def teaser txt
    if txt.blank?
      ""
    elsif txt.length<=50
      txt
    else
      txt[1..50]+"..."
    end
  end
  
  def page_title
    content_for?(:title) ? yield(:title) : controller.controller_name.titleize + "|"+ controller.action_name.titleize
  end
  
  def title(page_title)
    provide(:title, page_title)
    page_title
  end
end
