class Trace < ActiveRecord::Base
  
  belongs_to :habit
  
  scope :complete, where(:trace_complete => true)
  scope :incomplete, where(:trace_complete => false)
  
  
  def self.css(month, i, j)
    css_value = ""
    if (Time.days_in_month(month.month,month.year) + month.wday - 6 .. Time.days_in_month(month.month,month.year) + month.wday).include?(i*7 + j)
      css_value = "last_week"
    end

    if j == 7
      css_value = css_value + " last_day_of_week"
    end
    
    if Time.days_in_month(month.month,month.year) + month.wday == (i*7 + j)
      css_value = css_value + " last_day_of_month"      
    end
    
    css_value
  end
  
  def self.empty_day(month, i, j)
    if (month.wday + 1..Time.days_in_month(month.month,month.year) + month.wday).include?(i*7 + j)
      true
    else
      false
    end
  end
  
  def self.run_trace(traces, month, i, j)
    trace_str = ""
    num = (i*7 + j) - month.wday - 1
    date = month + num.days
    trace = traces.find {|item| item.trace_date == date}
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
  
  def self.calender_date(traces, month, i, j, habit)
    trace_str = ""
    num = (i*7 + j) - month.wday - 1
    date = month + num.days
    trace = traces.find {|item| item.trace_date == date}
    # unless trace
    #       trace_str = date.day
    #     end
    if trace
      TracesHelper.link_to_update_trace("", trace.id)
    else
      if date > DateTime.now || date < habit.created_at.beginning_of_day
        date.day
      else
        TracesHelper.link_to_create_trace(date.day, habit, date)
      end
    end
  end
  
end
