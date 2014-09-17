describe ImlLogisticsApi::Order do
  it 'validates children entities' do
    order = build(:order)
    order.goods_measure.volume = nil
    expect(order).not_to be_valid

    order = build(:order)
    order.condition.delivery.issue = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'
    expect(order).not_to be_valid
  end
end
