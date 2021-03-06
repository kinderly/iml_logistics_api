require_relative 'order_action'
require_relative 'condition'
require_relative 'self_delivery'
require_relative 'goods_measure'
require_relative 'item'
require_relative 'region'
require_relative 'consignee'

module ImlLogisticsApi
  class Order < OrderAction
    field :condition, use: 'R', type: ImlLogisticsApi::Condition
    field :region, use: 'R', type: ImlLogisticsApi::Region
    field :consignee, use: 'R', type: ImlLogisticsApi::Consignee
    field :self_delivery, use: 'R', type: ImlLogisticsApi::SelfDelivery
    field :goods_measure, use: 'R', type: ImlLogisticsApi::GoodsMeasure
    field :bar_code, use: 'O', pattern: 'n13', tag: 'barCode'
    field :goods_items, use: 'R', array: true, tag: 'GoodsItems', type: ImlLogisticsApi::Item

    def initialize
      @goods_items = []
      @condition = ImlLogisticsApi::Condition.new
      @region = ImlLogisticsApi::Region.new
      @consignee = ImlLogisticsApi::Consignee.new
      @self_delivery = ImlLogisticsApi::SelfDelivery.new
      @goods_measure = ImlLogisticsApi::GoodsMeasure.new
    end
  end
end
