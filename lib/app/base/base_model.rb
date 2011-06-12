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

module MagentoXMLRPCStub
  class BaseModel

    attr_accessor :data

    class << self
      attr_accessor :model_name

      def magento_model_name(name)
        @model_name = name
      end
    end

    def initialize(log, data)
      @log = log
      @data = data
    end

    def model
      raise "No model defined on this class" unless self.class.model_name
      self.class.model_name
    end

    def list
      @log.info "list method called"
      @data[model] || []
    end

    def info(id)
      pp @data[model][id]
      @log.info "info method called"
      @data[model][id] 
    end

    def create
      @log.info "create method called"
      false
    end

    def update
      @log.info "update method called"
      false
    end

    def delete
      @log.info "delete method called"
      false
    end
  end
end