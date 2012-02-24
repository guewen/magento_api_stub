#    MagentoAPIStub
#    Copyright (C) 2011 Guewen Baconnier
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'logger'
require 'xmlrpc/server'
require 'pp'

require "magento_api_stub/version"
require 'magento_api_stub/app/base/base_model'
require 'magento_api_stub/app/api_base_models/catalog_product'
require 'magento_api_stub/app/api_base_models/sales_order'


module MagentoAPIStub
  class Server
    attr_accessor :data
    attr_reader :xmlrpc_server

    def initialize(data)
      @data = data
      @log = Logger.new($stdout)

      @xmlrpc_server = XMLRPC::Server.new

      @xmlrpc_server.add_handler('login') do |login, password|
        @log.info "Logged with user #{login} and password #{password}"
        true
      end

      @xmlrpc_server.add_handler('call') do |session, model_method, *args|
        @log.info "Called method #{model_method}"
        call(model_method, *args)
      end
#
#      BaseModel.model_classes.each do |class_model|
#        @xmlrpc_server.add_handler(class_model.model_name, class_model.new(@log, @data[class_model.model_name]))
#      end

      # TODO add a config file for custom models and add handlers for them too

      @xmlrpc_server.set_default_handler do |name, *args|
        raise XMLRPC::FaultException.new(-99, "Method #{name} missing" +
                                         " or wrong number of parameters!")
      end
    end

    def call(model_method, *args)
      model, method = model_method.split('.')
      class_model = BaseModel.class_for(model)
      # TODO use singleton ?
      instance_model = class_model.new(@log, @data[class_model.model_name])
      instance_model.send(method.to_sym, *args)
    end

    def parse_file(parse_type='yaml')
      # set data from a file
      raise NotImplementedError
    end

    def run
      @xmlrpc_server.serve
      @xmlrpc_server.mount("index.php/api/xmlrpc/", @xmlrpc_server)
    end
  end
end


# Test stuff
server = MagentoAPIStub::Server.new(
    {'catalog_product' => {
        [1, 'SKU1'] =>
            {'name' => 'Product 1',
             'price' => 10.0}
    },
     'sales_order' => test_orders
    }
)

server.run

#require 'xmlrpc/client'
#require 'pp'
#class XMLRPC::Client
#  def set_debug
#    @http.set_debug_output($stderr);
#  end
#end
#server = XMLRPC::Client.new("127.0.0.1", "/index.php/api/xmlrpc/", 8080)
#server.set_debug
#pp server.call("sales_order.info", '100009493')