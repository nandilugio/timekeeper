module Timekeeper

  class TaskGroup < ActiveRecord::Base

    has_many :tasks

    def self.default
      where(default: true).first
    end

  end

end
