module Timekeeper

    class Task < ActiveRecord::Base
        belongs_to :task_group
        has_many :time_lapses


    end

end