if defined?(ActiveRecord)
  ActiveRecord::Base.class_eval do
    def self.has_many_kindeditor_assets(*args)
      options = args.extract_options!
      asset_name = args[0] ? args[0].to_s : 'assets'
      has_many asset_name.to_sym, :class_name => 'Kindeditor::Asset', :as => :owner, :dependent => options[:dependent]
    
      class_name = self.name
      Kindeditor::Asset.class_eval do
        belongs_to :owner, :polymorphic => true
      end
    end
  end
end