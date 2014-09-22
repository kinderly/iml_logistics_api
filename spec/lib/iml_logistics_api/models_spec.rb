{
  ImlLogisticsApi::Address => :address,
  ImlLogisticsApi::Consignee => :consignee,
  ImlLogisticsApi::Detail => :detail,
  ImlLogisticsApi::Item => :item,
  ImlLogisticsApi::RepresentativePerson => :representative_person,
  ImlLogisticsApi::Delivery => :delivery,
  ImlLogisticsApi::Condition => :condition,
  ImlLogisticsApi::Region => :region,
  ImlLogisticsApi::SelfDelivery => :self_delivery,
  ImlLogisticsApi::GoodsMeasure => :goods_measure,
  ImlLogisticsApi::Order => :order,
  ImlLogisticsApi::Message => [:message, :test_message],
  ImlLogisticsApi::DeliveryRequest => [:delivery_request, :test_delivery_request]
}.each do |klass, factories|

  factories = factories.is_a?(Array) ? factories : [factories]

  factories.each do |factory|
    describe klass do
      before(:each) do
        @ent = build(factory)
      end

      it 'is valid' do
        expect(@ent).to be_valid
      end

      it 'it serializes as XML' do
        expect{puts @ent.to_xml}.not_to raise_error
      end
    end
  end
end
