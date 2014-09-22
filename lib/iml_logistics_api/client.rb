require 'net/http'
require "net/https"

module ImlLogisticsApi
  class Client
    HOST = 'request.imlogistic.ru'

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
      iml_folder = check_folder(folder)
      resp = request("/#{iml_folder}", :get)
      xml = resp.body
      FileListResponse.parse(xml)
    end

    def get_file(folder, file)
      path = "/#{check_folder(folder)}/#{file}"
      resp = request(path, :get)
      resp.body
    end

    protected

    def check_folder(folder)
      iml_folder = FOLDERS[folder.to_sym]
      raise ImlLogisticsApi::Exceptions::Error, "Invalid folder '#{folder}'" if iml_folder.nil?
      iml_folder
    end

    def request(path, method)
      req = case method
      when :get
        Net::HTTP::Get.new(path)
      when :post
        Net::HTTP::Post.new(path)
      when :delete
        Net::HTTP::Delete.new(path)
      end

      req.basic_auth(@login, @password)
      http = Net::HTTP.new(HOST, 443)
      http.use_ssl = true
      http.request(req)
    end

  end
end
