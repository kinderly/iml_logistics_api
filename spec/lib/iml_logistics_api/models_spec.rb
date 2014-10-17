{
  ImlLogisticsApi::Address => :address,
  ImlLogisticsApi::Consignee => :consignee,
  ImlLogisticsApi::Detail => :detail,
  ImlLogisticsApi::Item => :item,
  ImlLogisticsApi::Communication => :communication,
  ImlLogisticsApi::RepresentativePerson => :representative_person,
  ImlLogisticsApi::Delivery => :delivery,
  ImlLogisticsApi::Condition => :condition,
  ImlLogisticsApi::Region => :region,
  ImlLogisticsApi::SelfDelivery => :self_delivery,
  ImlLogisticsApi::GoodsMeasure => :goods_measure,
  ImlLogisticsApi::BaseOrder => [:base_order],
  ImlLogisticsApi::OrderAction => [:order_action],
  ImlLogisticsApi::Order => [:order, :test_order],
  ImlLogisticsApi::Message => [:message, :test_message],
  ImlLogisticsApi::DeliveryRequest => [:delivery_request, :test_delivery_request]
}.each do |klass, factories|

  factories = factories.is_a?(Array) ? factories : [factories]

  describe klass do
    factories.each do |factory|
      it "is valid  (#{factory})" do
        @ent = build(factory)
        expect(@ent).to be_valid
      end

      it "it serializes as XML (#{factory})" do
        @ent = build(factory)
        expect{puts @ent.to_xml}.not_to raise_error
      end
    end
  end
end
