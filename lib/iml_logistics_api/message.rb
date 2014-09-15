module ImlLogisticsApi
  class Message
    include ImlLogisticsApi::Validated

    field :sender, use: 'R', pattern: 'an..35'
    field :recipient, use: 'R', pattern: 'an..35'

  end
end
