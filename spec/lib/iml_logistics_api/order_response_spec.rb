describe ImlLogisticsApi::OrderResponse do
  it 'serializes as xml' do
    or_a = build(:order_response, :with_barcode)
    xml = nil
    expect{xml = or_a.to_xml}.not_to raise_error
    puts xml
  end


  it 'parses xml' do
    or_a = build(:order_response, :with_barcode)
    xml = or_a.to_xml
    or_b = described_class.from_xml(xml)
    expect(or_b.barcode).to eq(or_a.barcode)

    p or_a
    p or_b
  end

  it 'has accessors' do
    or_r = described_class.new
    expect(or_r).to respond_to(:order_status=)
  end
end
