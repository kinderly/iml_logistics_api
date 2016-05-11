require 'net/http'
require "net/https"
require_relative 'lists'


module ImlLogisticsApi
  class Client
    HOST = 'request.iml.ru'

    FOLDERS = {
      inbox: 'Inbox',
      outbox: 'Outbox',
      report: 'Report',
      list: 'List'
    }

    def initialize(login, password, test = false, verify_certificate = true)
      @login = login
      @password = password
      @test = test
      @verify_certificate = verify_certificate
    end

    # Возвращает массив имен файлов в указанном каталоге
    def folder_contents(folder)
      iml_folder = check_folder(folder)
      resp = request("/#{iml_folder}", :get)
      xml = resp.body
      ImlLogisticsApi::Lists.parse_file_list(xml)
    end

    # Возвращает содержимое файла в виде XML-строки
    def get_file(folder, file)
      path = "/#{check_folder(folder)}/#{file}"
      resp = request(path, :get)
      resp.body
    end

    # Возвращает содержимое всех файлов каталога в виде массива хэшей
    def get_all_files(folder)
      res = []
      folder_contents(folder).each do |file|
        el = {
          filename: file,
          text: get_file(folder, file)
        }

        yield el[:filename], el[:text] if block_given?
        res << el
      end

      res
    end

    # Записывает файл в указанный каталог
    def put_file(folder, file, text)
      path = "/#{check_folder(folder)}/#{file}"
      resp = request(path, :post, text)
      resp.body
    end

    # Удаляет файл из указанного каталога
    def delete_file(folder, file)
      path = "/#{check_folder(folder)}/#{file}"
      resp = request(path, :delete)
      resp.body
    end

    # Удаляет все файлы из указанного каталога
    def clear_folder(folder)
      folder_contents(folder).each do |file|
        delete_file(folder, file)
      end
    end

    # Возвращает справочник по регионам в виде массива хэшей
    def regions
      xml = get_file(:list, 'Region.xml')
      ImlLogisticsApi::Lists.parse_regions(xml)
    end

    # Возвращает справочник пунктов самомвывоза в виде массива хэшей
    def self_delivery
      xml = get_file(:list, 'SelfDelivery.xml')
      ImlLogisticsApi::Lists.parse_self_delivery(xml)
    end

    # Возвращает справочник способов доставки в виде массива хэшей
    def services
      xml = get_file(:list, 'Service.xml')
      ImlLogisticsApi::Lists.parse_service(xml)
    end

    # Возвращает справочник статусов доставки заказа в виде массива хэшей
    def delivery_statuses
      xml = get_file(:list, 'DeliveryStatus.xml')
      ImlLogisticsApi::Lists.parse_delivery_statuses(xml)
    end

    # Возвращает справочник статусов заказа в виде массива хэшей
    def order_statuses
      xml = get_file(:list, 'OrderStatus.xml')
      ImlLogisticsApi::Lists.parse_order_statuses(xml)
    end

    # Возвращает справочник методов API в виде массива хэшей
    def api_actions
      xml = get_file(:list, 'ApiAction.xml')
      ImlLogisticsApi::Lists.parse_api_actions(xml)
    end

    # Возвращает справочник ответов API в виде массива хэшей
    def api_responses
      xml = get_file(:list, 'ApiResponse.xml')
      ImlLogisticsApi::Lists.parse_api_responses(xml)
    end

    # Запрос на доставку заказов
    def delivery_request(orders)
      message = ImlLogisticsApi::Message.new
      message.sender = @login
      message.recipient = ''
      message.test = 1 if @test

      dr = DeliveryRequest.new
      dr.orders = orders.is_a?(ImlLogisticsApi::Order) ? [orders] : orders
      dr.message = message

      text = dr.to_xml
      filename = dr.filename

      resp = put_file(:inbox, filename, text)
      {
        response: resp,
        filename: filename,
        request: text,
        message_reference: message.reference
      }
    end

    # Получить ответ из файла
    def read_reponse(file)
      xml = get_file(:outbox, file)
      {response: ImlLogisticsApi::ResponseRequest.from_xml(xml), text: xml}
    end

    # Прочитать и распарсить все ответы из папки Outbox
    def read_all_responses
      res = []

      get_all_files(:outbox) do |filename, text|
        response = ImlLogisticsApi::ResponseRequest.from_xml(text)
        res << {filename: filename, response: response, text: text}
        yield filename, response, text if block_given?
      end

      res
    end

    protected

    def check_folder(folder)
      iml_folder = FOLDERS[folder.to_sym]
      raise ImlLogisticsApi::Exceptions::Error, "Invalid folder '#{folder}'" if iml_folder.nil?
      iml_folder
    end

    def request(path, method, text = nil)
      req = case method
      when :get
        Net::HTTP::Get.new(path)
      when :post
        Net::HTTP::Post.new(path)
      when :delete
        Net::HTTP::Delete.new(path)
      end

      req.body = text if text
      req.basic_auth(@login, @password)
      http = Net::HTTP.new(HOST, 80)
      resp = http.request(req)

      if '200' != resp.code.to_s
        raise ImlLogisticsApi::Exceptions::Error, "#{resp.code} server error"
      end

      resp
    end

  end
end
