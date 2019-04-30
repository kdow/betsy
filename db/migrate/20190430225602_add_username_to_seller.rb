class AddUsernameToSeller < ActiveRecord::Migration[5.2]
  def change
    add_column(:sellers, :username, :string)
    add_column(:sellers, :email, :string)
  end
end
