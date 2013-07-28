module Timekeeper

  class TimeLapse < ActiveRecord::Base
    belongs_to :task

  end

end
