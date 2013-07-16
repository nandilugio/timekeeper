require "spec_helper"

describe Timekeeper::Base do

    let(:test_db_path) { "/tmp/timekeeper_test.sqlite3" }

    before do
        File.delete test_db_path if File.exists? test_db_path
    end

    subject { Timekeeper::Base.new test_db_path }

    context do

        before do
            new_group = subject.add_group("test")
            subject.activate_group new_group.id
        end

        context do

            it "creates an unnamed task in the active group and starts logging time to it when user calls start" do

                new_task = subject.start

                subject.list.tap do |g|
                    g.should be_one
                    g.first.name.should == "test"
                    g.first.tasks.tap do |t|
                        t.should be_one
                        t.first.should == new_task
                    end
                end

            end

            # it "creates a named task in the active group and starts logging time to it when the user calls start with the name of the task" do

            #     new_task = subject.start "new task"

            #     subject.list.tap do |g|
            #         g.should be_one
            #         g.first.name.should == "test"
            #         g.first.tasks.tap do |t|
            #             t.should be_one
            #             t.first.should == new_task
            #         end
            #     end

            # end

            # it "creates a named task in a particular group and starts logging time to it when the user calls start with the names of the task and the group" do
            # end

            # it "starts logging time to an existing named task when the user calls start with the name of the task, independently of the group it belongs" do
            # end

            # it "" do
            # end

        end

    end
    
end
