#    FakeMagentoAPI
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

require 'app/base/base_model'
require 'app/api_base_models/catalog_product'


module MagentoXMLRPCStub
  class MagentoStubBase
    attr_accessor :data
    attr_reader :xmlrpc_server

    def initialize(data)
      @data = data
      @log = Logger.new($stdout)
    end

    def parse_file(parse_type='yaml')
      # set data from a file
      raise NotImplementedError
    end

    def serve
      @xmlrpc_server = XMLRPC::Server.new

      # TODO add handler for each base model (loop on a hash?)
      @xmlrpc_server.add_handler('catalog_product', CatalogProduct.new(@log, @data))

      # TODO add a config file for custom models and add handlers for them

      @xmlrpc_server.serve
    end
  end
end


# Test stuff
server = MagentoXMLRPCStub::MagentoStubBase.new(
  {'catalog_product' => {
     [1, 'SKU1'] =>
         {'name' => 'Product 1',
          'price' => 10.0}
      }
  }
)

server.serve

#require 'xmlrpc/client'
#server = XMLRPC::Client.new("127.0.0.1", "/RPC2", 8080)
#puts server.call("catalog_product.list")