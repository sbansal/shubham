class TracesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def create
    @trace = Trace.new(:habit_id => params[:habit_id], 
      :trace_date => params[:trace_date], :trace_complete => true)
    @trace.save
  end
  
  def update
    @trace = Trace.find(params[:id])
    @trace.update_attributes(:trace_complete => !@trace.trace_complete)
  end
end
