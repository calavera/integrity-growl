require 'rubygems'
require 'integrity'
require 'ruby-growl'

module Integrity
  class Notifier
    class Growl < Notifier::Base
      
      def initialize(build, config = {})
        @growl = Growl.new "localhost", "Integrity", ["Integrity build notification"]
        @addresses = config[:addresses].nil? ? [] : config.delete(:addresses).split(/,|\s+/)
        @growl = @addresses.map do |address|
          Growl.new address, "Integrity", ["Integrity build notification"]
        end
        super
      end
      
      def self.to_haml
        File.read File.dirname(__FILE__) / "config.haml"
      end
      
      def deliver!
        @growl.each do |g|
          g.notify "Integrity build notification", short_message, message
        end
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