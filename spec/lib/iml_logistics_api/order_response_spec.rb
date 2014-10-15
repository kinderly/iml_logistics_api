describe ImlLogisticsApi::OrderResponse do
  it 'parses xml' do
    or_a = build(:order_response)
    xml = or_a.to_xml
    or_b = described_class.from_xml(xml)
    expect(or_b.barcode).to eq(or_a.barcode)

    p or_a
    p or_b
  end
end
