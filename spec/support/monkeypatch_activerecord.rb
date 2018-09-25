# frozen_string_literal: true

ActiveRecord::Base.instance_eval do
  mattr_accessor :shared_connection

  def self.connection
    self.shared_connection ||= retrieve_connection
  end
end
