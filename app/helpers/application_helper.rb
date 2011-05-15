module ApplicationHelper
  
  def notice
    
    unless flash[:notice].blank?
      
      content_tag :p, :id => 'notice' do
        flash[:notice]      
      end
    
    end
    
  end
  
end
