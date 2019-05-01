class AddUidAndProviderToSellers < ActiveRecord::Migration[5.2]
  def change
    add_column :sellers, :uid, :integer
    add_column :sellers, :provider, :string
  end
end
