require_relative 'validated'

module ImlLogisticsApi
  class Region
    REGIONS = [
      'БРЯНСК',
      'ВЛАДИМИР',
      'ВОЛОГДА',
      'ЕКАТЕРИНБУРГ',
      'ИВАНОВО',
      'КАЛУГА',
      'КОСТРОМА',
      'МОСКВА',
      'НИЖНИЙ НОВГОРОД',
      'ОРЕЛ',
      'РЯЗАНЬ',
      'САНКТ-ПЕТЕРБУРГ',
      'ТВЕРЬ',
      'ТУЛА',
      'ТЮМЕНЬ',
      'ЧЕЛЯБИНСК',
      'ЯРОСЛАВЛЬ',
      'РОСТОВ-НА-ДОНУ'
    ]


    include ImlLogisticsApi::Validated

    xml_options tag: 'Region'

    field :departure, use: 'R', pattern: 'an..20'
    field :destination, use: 'R', pattern: 'an..20'
  end
end

