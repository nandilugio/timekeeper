module Timekeeper

    class TaskGroup < ActiveRecord::Base
        has_many :tasks

        def self.active
            where(active: true).first
        end

    end

end