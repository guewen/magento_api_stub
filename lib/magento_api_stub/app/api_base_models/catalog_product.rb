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

module MagentoAPIStub
  class CatalogProduct < BaseModel

    magento_model_name 'catalog_product'

    def info(product_id_or_sku, store_view=nil, attributes=nil)
      attributes ||= {}
      super(product_id_or_sku)
    end
  end
end