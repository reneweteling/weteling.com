class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    
    create_table :blogs do |t|
      t.string :title
      t.timestamp :date
      t.text :content
      t.string :image
      t.timestamps
    end

    create_table :tags do |t|
      t.string :title
      t.belongs_to :tag, foreign_key: true
    end

    create_table :blogs_tags do |t|
      t.belongs_to :blog, foreign_key: true
      t.belongs_to :tag, foreign_key: true
    end

    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :message
      t.timestamps
    end

  end
end
