class TracesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def create
    @trace = Trace.new(:habit_id => params[:habit_id], 
      :tracedate => params[:tracedate], :trace_complete => true)
    @trace.save
  end
  
  def update
    @trace = Trace.find(params[:id])
    if @trace.trace_complete
      @trace.update_attributes(:trace_complete => false)
    else
      @trace.destroy
    end
  end
end
