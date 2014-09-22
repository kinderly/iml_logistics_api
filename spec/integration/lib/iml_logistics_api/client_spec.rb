describe ImlLogisticsApi::Client, type: :integration do

  before(:each) do
    integration_yml = File.join(File.dirname(__FILE__), "../../integration.yml")
    @iml_credentials = YAML.load(File.read(integration_yml))
    @client = described_class.new(@iml_credentials['login'], @iml_credentials['password'], true)
  end

  describe '#folder_contents' do
    it 'lists folder contents' do
      fileList = @client.folder_contents(:list)
      expect(fileList).not_to be_empty
      puts fileList
    end
  end

  describe '#get_file' do
    it 'gets file contents' do
      fileList = @client.folder_contents(:list)

      fileList.each do |file|
        res = @client.get_file(:list, file)
        expect(res).not_to be_nil
        puts file
        puts res
      end
    end
  end

  [:self_delivery, :regions, :services, :delivery_statuses, :order_statuses, :api_actions, :api_responses].each do |method|
    describe "##{method}" do
      it 'works' do
        res = @client.send(method)
        expect(res).not_to be_empty
        puts res
      end
    end
  end
end
