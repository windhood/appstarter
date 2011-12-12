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
  
  def title(page_title, show_title = true)
    content_for(:title) { page_title.to_s }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end
end
