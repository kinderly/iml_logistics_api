require_relative 'base_order'
module ImlLogisticsApi
  class OrderAction < BaseOrder
    ACTIONS = ['CREATE', 'MODIFY', 'DELETE', 'STATUS']

    field :action, use: 'R', pattern: 'an..20'
  end
end
