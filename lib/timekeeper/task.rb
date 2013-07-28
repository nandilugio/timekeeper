module Timekeeper

  class Task < ActiveRecord::Base

    belongs_to :task_group
    has_many :time_lapses

    def running?
      time_lapses.where(ends_at: nil).any?
    end

    def start_logging
      time_lapses.create(starts_at: Time.now)
    end

  end

end
