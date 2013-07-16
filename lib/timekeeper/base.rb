require "active_record"

module Timekeeper
  
    class Base

        def initialize dbpath = File.expand_path("~/.timekeeper")
            @dbpath = dbpath
            bootstrap
        end

        def start task_id=nil, project_id=:active
            Task.create task_group: TaskGroup.active
        end

        def stop
        end

        def resume
        end

        def list
            TaskGroup.all
        end

        def add_group group_name
            TaskGroup.create name: group_name
        end

        def activate_group group_id
            TaskGroup.transaction do
                TaskGroup.update_all active: false
                task_group = TaskGroup.find group_id
                task_group.active = true
                task_group.save
            end
        end

        private

        def bootstrap
            unless File.exists? @dbpath
                dbsetup 
            else 
                dbconnect
            end
        end

        def dbconnect
            ActiveRecord::Base.establish_connection \
                adapter: "sqlite3",
                database: @dbpath
        end

        def dbsetup
            dbconnect
            ActiveRecord::Schema.define do
                
                create_table :task_groups do |t|
                    t.string :name
                    t.boolean :active, default: false
                end

                create_table :tasks do |t|
                    t.belongs_to :task_group
                    t.string :name
                end

                create_table :time_lapses do |t|
                    t.belongs_to :task
                    t.datetime :start
                    t.datetime :end
                end

            end
        end

    end

end
