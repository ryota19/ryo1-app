class ChangePostsNameNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :text, false
  end
end
