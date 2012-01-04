class Basketization < ActiveRecord::Base
  belongs_to :task
  belongs_to :basket
end
