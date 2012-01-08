module TracesHelper
  include ActionView::Helpers::UrlHelper
  
  def self.link_to_create_trace(name, habit, tracedate, display_link)
    ActionController::Base.helpers.link_to_if display_link, name, "/create_trace/#{habit.id}/#{tracedate}", :remote => true
  end

  def self.link_to_update_trace(name, trace_id, display_link)
    ActionController::Base.helpers.link_to_if display_link, name, "/update_trace/#{trace_id}", :remote => true
  end
  
end
