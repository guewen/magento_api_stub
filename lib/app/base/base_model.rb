#    MagentoXMLRPCStub
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

    ###############################
    # Class methods
    class << self
      attr_reader :model_name, :model_classes
    end

    def self.magento_model_name(name)
      @model_name = name
    end

    @model_classes = []

    def self.inherited(subclass)
      BaseModel.model_classes
      BaseModel.model_classes << subclass
    end

    def self.class_for(model_method)
      model = model_method.split('.')[0]
      BaseModel.model_classes.each do |sub_model|
        return sub_model if sub_model.model_name == model
      end
    end

    ###############################
    # Instance methods

    attr_accessor :data

    def initialize(log, data)
      @log = log
      @data = data
    end

    def model
      raise XMLRPC::FaultException.new(1, "No Magento model defined on class #{self.class}") unless self.class.model_name
      self.class.model_name
    end

    def list(filters=[])
      @log.info "list method called"
      @data || []
    end

    def info(id)
      @log.info "info method called with id #{id}"
      @data[id]
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