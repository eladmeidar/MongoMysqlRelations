require "mongo_mysql_relations/version"

module MongoMysqlRelations
  def self.included(base)
    base.class_eval do
      extend  ClassMethods
    end
  end

  module ClassMethods
    ##################################################################################
    # Connection methods from mongoid to mysql
    def to_mysql_belongs_to(name, options = {})
      field "#{name}_id", type: Integer
      object_class = options[:class] || name.to_s.titleize.delete(' ').constantize
      self.instance_eval do
        define_method(name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end

          if self.instance_variable_get("@#{name}").blank? 
            self.instance_variable_set("@#{name}", object_class.where(object_class.primary_key => self.send("#{name}_id")).first)
          end

          self.instance_variable_get("@#{name}")
        end

        define_method("#{name}=(new_instance)") do
          self.send("#{name}_id=", new_instance.id)
          self.instance_variable_set("@#{name}", nil)
        end
      end
    end

    def to_mysql_has_many(name, options = {})
      plural_name = name.to_s.pluralize
      foreign_key = options[:foreign_key] || "#{self.name.underscore}_id"
      object_class = options[:class] || name.to_s.singularize.titleize.delete(' ').constantize
      self.instance_eval do
        define_method(plural_name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end
          
          if self.instance_variable_get("@#{name}").blank? 
            self.instance_variable_set("@#{name}", object_class.where(foreign_key => self.id.to_s))
          end

          self.instance_variable_get("@#{name}")
        end
      end
    end

    def to_mysql_has_one(name, options = {})
      foreign_key = options[:foreign_key] || "#{self.name.underscore}_id"
      object_class = options[:class] || name.to_s.titleize.delete(' ').constantize
      self.instance_eval do
        define_method(name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end

          if self.instance_variable_get("@#{name}").blank? 
            self.instance_variable_set("@#{name}", object_class.where(foreign_key => self.id.to_s).first)
          end

          self.instance_variable_get("@#{name}")
        end
      end
    end
    ##################################################################################

    ##################################################################################
    # Connection methods from mysql to mongoid
    def from_mysql_belongs_to(name, options = {})
      object_class = options[:class] || name.to_s.titleize.delete(' ').constantize
      self.instance_eval do
        define_method(name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end

          if self.instance_variable_get("@#{name}").blank? 
            self.instance_variable_set("@#{name}", object_class.where(:id => self.send("#{name}_id")).first)
          end

          self.instance_variable_get("@#{name}")
        end

        define_method("#{name}=(new_instance)") do
          self.send("#{name}_id=", new_instance.id)
          self.instance_variable_set("@#{name}", nil)
        end
      end
    end

    def from_mysql_has_many(name, options = {})
      plural_name = name.to_s.pluralize
      foreign_key = options[:foreign_key] || "#{self.name.underscore}_id"
      object_class = options[:class] || name.to_s.singularize.titleize.delete(' ').constantize
      self.instance_eval do
        define_method(plural_name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end

          if self.instance_variable_get("@#{name}").blank? 
            self.instance_variable_set("@#{name}", object_class.where(foreign_key => self.id))
          end

          self.instance_variable_get("@#{name}")
        end
      end
    end

    def from_mysql_has_one(name, options = {})
      foreign_key = options[:foreign_key] || "#{self.name.underscore}_id"
      object_class = options[:class] || name.to_s.titleize.delete(' ').constantize
      self.instance_eval do
        define_method(name) do |reload = false|
          if reload
            self.instance_variable_set("@#{name}", nil)
          end

          if self.instance_variable_get("@#{name}").blank? 
            self.instance_variable_set("@#{name}", object_class.where(foreign_key => self.id).first)
          end

          self.instance_variable_get("@#{name}")
        end
      end
    end
    ##################################################################################
  end
end
