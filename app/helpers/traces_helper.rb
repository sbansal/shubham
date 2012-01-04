module TracesHelper
  include ActionView::Helpers::UrlHelper
  
  def self.link_to_create_trace(name, habit, trace_date)
    ActionController::Base.helpers.link_to name, "/create_trace/#{habit.id}/#{trace_date}", :remote => true
  end

  def self.link_to_update_trace(name, trace_id)
    ActionController::Base.helpers.link_to name, "/update_trace/#{trace_id}", :remote => true
  end
  
end
