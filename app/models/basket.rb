class Basket < ActiveRecord::Base
  has_many :basketization
  has_many :tasks, :through => :basketization
  
  
  def css_property(name)
    if name == 'Action Item'
      css = "action_item"
    elsif name == 'Back Burner'
      css = "back_burner"
    else
      css = "reference"
    end
    css
  end
end
