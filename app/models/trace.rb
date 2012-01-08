class Trace < ActiveRecord::Base
  
  belongs_to :habit
  
  scope :complete, where(:trace_complete => true)
  scope :incomplete, where(:trace_complete => false)
  
  # helper method for building the calender
  # TODO move this outside in the helper class
  # month - beginning of month date time
  # i - number of weeks painted in a calender month (0 -> 5)
  #j - day of the week (1 -> 7)
  def self.css(month, i, j)
    css_value = ""
    
    # if the current date based on i.j value in the last week 
    if (Time.days_in_month(month.month,month.year) + month.wday - 6 .. Time.days_in_month(month.month,month.year) + month.wday).include?(i*7 + j)
      css_value = "last_week"
    end

    # if j = 7 then its the last day of the week
    if j == 7
      css_value = css_value + " last_day_of_week"
    end
    
    # if the i,j date is last day of the month
    if Time.days_in_month(month.month,month.year) + month.wday == (i*7 + j)
      css_value = css_value + " last_day_of_month"      
    end
    
    css_value
  end
  
  # if the date based on i,j would actually be on the calender month, show it else fade it
  def self.empty_day(month, i, j)
    if ((month.wday + 1)..(Time.days_in_month(month.month,month.year) + month.wday)).include?(i*7 + j)
      true
    else
      false
    end
  end
  
  
  # Go through all the traces to find the trace for the (i,j)th day of the month and get the 
  # trace complete value
  # If the trace value is true it is green (good), else red (bad)
  # No trace value means that trace was not reported for the day
  def self.run_trace(traces, month, i, j)
    trace_str = ""
    # num refers to the number of days that needed to be added to the beginning of month date time 
    # to come up with the date time for the day corresponding to the i,j value
    # Since j started from 1 we need to subtract 1. e.g. If beginning of month was a sunday then 
    # for the first day of the month, num should be zero
    num = (i*7 + j) - month.wday - 1
    date = month + num.days
    # trace = traces.find {|item| item.trace_date == date}
    trace = traces.find {|item| item.tracedate == date}
    if trace
      if trace.trace_complete
        trace_str = "good"
      else
        trace_str = "bad"
      end
    #   logger.info "Trace for  month - " + month.month.to_s + " num " + num.to_s + " and date " + date.to_s + " and trace string " + trace_str
    # else 
    #   logger.info "No trace for  month - " + month.month.to_s + " num " + num.to_s + " and date " + date.to_s
    end
    trace_str
  end
  
  def self.calender_date(traces, month, i, j, habit, display_link)
    trace_str = ""
    num = (i*7 + j) - month.wday - 1
    date = month + num.days
    # trace = traces.find {|item| item.trace_date == date}
    trace = traces.find {|item| item.tracedate == date}
    if trace
      TracesHelper.link_to_update_trace("", trace.id, display_link)
    else
      if date > Date.parse(Time.now.in_time_zone.to_s) || date < Date.parse(habit.created_at.to_s)    
        # logger.info "Date = " + date.to_s + ", and Today = " + Time.now.to_s + " and month = " + month.to_s + " for zone - " + Time.zone.to_s
        date.day
      else
        TracesHelper.link_to_create_trace(date.day, habit, date, display_link)
      end
    end
  end
  
end
