describe ImlLogisticsApi::Item do
  before(:each) do
    @item = build(:item)
  end

  it 'is valid' do
    expect(@item).to be_valid
  end

  it 'serializes as XML' do
    expect{puts @item.to_xml}.not_to raise_error
  end
end
