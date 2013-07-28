require "active_record"

module Timekeeper

  class Base

    def initialize dbpath = File.expand_path("~/.timekeeper")
      @dbpath = dbpath
      bootstrap
    end

    def start task_name = nil, task_group_name = nil

      task = Task.find_by name: task_name

      if task.nil?

        if task_group_name.nil?
          task_group = TaskGroup.default
        else
          task_group = TaskGroup.find_by name: task_group_name || TaskGroup.default
        end

        task = Task.create name: task_name, task_group: task_group

      end

      # TODO: start logging time

      return task

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

    def default_group group_name
      TaskGroup.transaction do
        TaskGroup.update_all default: false
        task_group = TaskGroup.find_by name: group_name
        task_group.default = true
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
          t.boolean :default, default: false
        end

        create_table :tasks do |t|
          t.belongs_to :task_group
          t.string :name
        end

        create_table :time_lapses do |t|
          t.belongs_to :task
          t.datetime :starts_at
          t.datetime :ends_at
        end

      end
    end

  end

end
