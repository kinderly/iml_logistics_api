require 'net/http'
require "net/https"
require_relative "lists"
require_relative "file_list_response"


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
      ImlLogisticsApi::FileListResponse.parse(xml)
    end

    def get_file(folder, file)
      path = "/#{check_folder(folder)}/#{file}"
      resp = request(path, :get)
      resp.body
    end

    def regions
      xml = get_file(:list, 'Region.xml')
      ImlLogisticsApi::Lists.parse_regions(xml)
    end

    def self_delivery
      xml = get_file(:list, 'SelfDelivery.xml')
      ImlLogisticsApi::Lists.parse_self_delivery(xml)
    end

    def services
      xml = get_file(:list, 'Service.xml')
      ImlLogisticsApi::Lists.parse_service(xml)
    end

    def delivery_statuses
      xml = get_file(:list, 'DeliveryStatus.xml')
      ImlLogisticsApi::Lists.parse_delivery_statuses(xml)
    end

    def order_statuses
      xml = get_file(:list, 'OrderStatus.xml')
      ImlLogisticsApi::Lists.parse_order_statuses(xml)
    end

    def api_actions
      xml = get_file(:list, 'ApiAction.xml')
      ImlLogisticsApi::Lists.parse_api_actions(xml)
    end

    def api_responses
      xml = get_file(:list, 'ApiResponse.xml')
      ImlLogisticsApi::Lists.parse_api_responses(xml)
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
