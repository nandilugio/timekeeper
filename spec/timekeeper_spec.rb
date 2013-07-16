require "spec_helper"

module Timekeeper

    describe Timekeeper::Base do

        let(:test_db_path) { "/tmp/timekeeper_test.sqlite3" }

        before do
            File.delete test_db_path if File.exists? test_db_path
        end

        subject { Timekeeper::Base.new test_db_path }

        context do

            before do
                new_group = subject.add_group "test default group"
                subject.default_group new_group.name
            end

            it "creates an unnamed task in the default group and starts logging time to it when user calls start" do

                new_task = subject.start

                new_task.name.should == nil
                new_task.task_group.should == TaskGroup.default

            end

            it "creates a named task in the default group and starts logging time to it when the user calls start with the name of the task" do

                new_task_name = "test new task"

                new_task = subject.start new_task_name
                
                new_task.name.should == new_task_name
                new_task.task_group.should == TaskGroup.default

            end

            it "creates a named task in a particular group and starts logging time to it when the user calls start with the names of the task and the group" do

                non_default_group_name = "test non default group"
                non_default_group = subject.add_group non_default_group_name

                new_task_name = "test new task"

                new_task = subject.start new_task_name, non_default_group_name
                
                new_task.name.should == new_task_name
                new_task.task_group.name.should == non_default_group_name

            end

            it "starts logging time to an existing named task when the user calls start with the name of the task, independently of the group it belongs" do

                non_default_group_name = "test non default group"
                non_default_group = subject.add_group non_default_group_name

                existing_task_name = "test task"
                existing_task = Task.create name: existing_task_name, task_group: non_default_group

                returned_task = subject.start existing_task_name
                
                returned_task.should == existing_task

            end

        end
        
    end

end
