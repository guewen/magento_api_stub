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

require 'app/api_models/base_model'
require 'app/api_models/catalog_product'

LOG =  Logger.new($stdout)

s = XMLRPC::Server.new
s.add_handler("catalog_product", CatalogProduct.new)
s.serve



#require 'xmlrpc/client'
#server = XMLRPC::Client.new("127.0.0.1", "/RPC2", 8080)
#puts server.call("sample.sum_and_difference", 1, 2)