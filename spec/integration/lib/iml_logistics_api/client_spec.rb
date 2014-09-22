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

  describe '#put_file' do
    it 'puts file contents' do
      expect{puts @client.put_file(:inbox, 'put_file_test.xml', '<test/>')}.not_to raise_error
      folder_contents =@client.folder_contents(:inbox)
      expect(folder_contents).to include('put_file_test.xml')
      @client.delete_file(:inbox, 'put_file_test.xml')
      folder_contents = @client.folder_contents(:inbox)
      expect(folder_contents).not_to include('put_file_test.xml')
    end
  end

  describe '#delete_file' do
    it 'deletes file from server' do
      expect{puts @client.put_file(:inbox, 'delete_file_test.xml', '<test/>')}.not_to raise_error
      folder_contents =@client.folder_contents(:inbox)
      expect(folder_contents).to include('delete_file_test.xml')
      @client.delete_file(:inbox, 'delete_file_test.xml')
      folder_contents = @client.folder_contents(:inbox)
      expect(folder_contents).not_to include('delete_file_test.xml')
    end
  end

  describe '#get_all_files' do
    it 'gets all files hash' do
      @client.get_all_files(:list).each do |file|
        puts file[:text]
      end
    end
  end

  describe '#clear_folder' do
    it 'deletes all files' do
      [:inbox, :outbox].each do |folder|
        expect{@client.clear_folder(folder)}.not_to raise_error
        expect(@client.folder_contents(folder)).to be_empty
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
