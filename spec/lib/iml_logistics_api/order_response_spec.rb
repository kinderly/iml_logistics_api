describe ImlLogisticsApi::OrderResponse do
  it 'parses xml' do
    or_a = build(:order_response)
    xml = or_a.to_xml
    or_b = described_class.from_xml(xml)
    expect(or_b.barcode).to eq(or_a.barcode)

    p or_a
    p or_b
  end

  it 'has accessors' do
    or_r = described_class.new
    # expect(or_r).to respond_to(:order_status)
    expect(or_r).to respond_to(:order_status=)
  end
end
