class Add < ActiveRecord::Migration[7.1]
  def change
    add_column :pages, :content_nl, :text
    rename_column :pages, :content, :content_en
  end
end
