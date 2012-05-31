class AddPhoneableToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :phoneable_id, :integer
    add_column :phones, :phoneable_type, :string
  end
end
