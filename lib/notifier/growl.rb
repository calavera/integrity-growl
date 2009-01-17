require 'rubygems'
require 'integrity'
require 'ruby-growl'

module Integrity
  class Notifier
    class Growl < Notifier::Base
      
      def initialize(build, config = {})
        @growl = Growl.new "localhost", "Integrity", ["Integrity build notification"]
        super
      end
      
      def to_haml
      end
      
      def deliver!
        @growl.notify "Integrity build notification", short_message, message
      end
      
      def message
        @message ||= <<-content
        #{build.project.name}: #{short_message} (at #{build.commited_at} by #{build.commit_author.name})
        Commit Message: '#{build.commit_message}'          
        Link: #{build_url}
content
      end
      
    end
  end
end