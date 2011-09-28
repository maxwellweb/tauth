require 'rubygems'
require 'activerecord'

ActiveRecord::Base.establish_connection(YAML.load_file("database.yml"))
begin

	ActiveRecord::Schema.define do
		create_table :users do |t|
			t.column :porvider, :string
			t.column :uid, :string
			t.column :name, :string
		end
	end
rescue ActiveRecord::StatementInvalid
end
