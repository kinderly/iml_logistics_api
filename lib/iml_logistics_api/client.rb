require 'net/http'
require_relative

module ImlLogisticsApi
  class Client
    HOST = 'imlogistic.ru'

    FOLDERS = {
      inbox: 'Inbox',
      outbox: 'Outbox',
      report: 'Report',
      list: 'List'
    }

    def initialize(login, password, test = false)
      @login = login
      @password = password
      @test = test
    end

    def folder_contents(folder)
      iml_folder = FOLDERS[folder]
      raise ImlLogisticsApi::Exceptions::Error, "Invalid folder '#{folder}'" if iml_folder.nil?
      request(iml_folder, :get)
    end

    protected

    def request(path, method)
      req = case method
      when :get
        Net::HTTP::Get.new(path)
      when :post
        Net::HTTP::Post.new(path)
      when :delete
        Net::HTTP::Delete.new(path)
      end

      Net::HTTP.start(HOST, 80) do |http|
        response = http.request(req)
      end
    end

  end
end
