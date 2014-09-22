require_relative 'validated'
require 'securerandom'
require 'date'

module ImlLogisticsApi
  class Message
    include ImlLogisticsApi::Validated

    xml_options tag: 'Message'

    field :sender, use: 'R', pattern: 'an..35'
    field :recipient, use: 'R', pattern: 'an..35'
    field :issue, use: 'R', pattern: 'an19'
    field :reference, use: 'R', pattern: 'an..35'
    field :version, use: 'R', pattern: 'an3'
    field :test, use: 'D', pattern: 'n1'

    def initialize
      self.reference = SecureRandom.uuid.gsub('-', '')
      self.issue = DateTime.now
      self.version = '1.0'
    end
  end
end
