require "thor"
require "timekeeper"

module Timekeeper

    class CLI < Thor

        desc "start", "Starts logging a task"
        def start task_id, project_id
            # TODO get names
            base.start task_name, project_id
        end

        desc "stop", "Stop logging current task"
        def stop
            base.stop
        end

        desc "resume", "Resume logging last task"
        def resume
            base.resume
        end

        private

        def base
            @base ||= Base.new
        end

    end

end
