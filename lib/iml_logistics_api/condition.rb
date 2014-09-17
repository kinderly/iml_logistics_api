# encoding: UTF-8
require_relative 'validated'
require_relative 'delivery'

module ImlLogisticsApi
  class Condition
    include ImlLogisticsApi::Validated

    SERVICES = {
      '24' => 'Безналичный Расчет',
      '24КО' => 'Кассовое Обслуживание',
      '24НАЛ' => 'Наличный Расчет',
      'В24' => 'Возврат Безналичный',
      'ЗАБОР' => 'Забор Товара',
      'С24' => 'Самовывоз Безналичный Расчет',
      'С24КО' => 'Самовывоз Кассовое Обслуживание',
      'С24НАЛ' => 'Самовывоз Наличный Расчет',
      'СВ24' => 'Самовывоз Возврат Безналичный',
      'Э24' => 'Экспресс Безналичный Расчет',
      'Э24КО' => 'Экспресс Кассовое Обслуживание',
      'Э24НАЛ' => 'Экспресс Наличный расчет',
      'ЭЗАБОР' => 'Экспресс Забор Товара'
    }.freeze

    xml_options tag: 'Condition'

    field :service, use: 'R', pattern: 'an..20'
    field :delivery, use: 'R', type: ImlLogisticsApi::Delivery
    field :comment, use: 'O', pattern: 'an..250'

  end
end
