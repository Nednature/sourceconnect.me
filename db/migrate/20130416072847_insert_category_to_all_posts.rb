class InsertCategoryToAllPosts < ActiveRecord::Migration
  def up
  	a = Category.new
  	a.name = "General"
  	a.description = "Anything that doesn't fit anywhere else"
  	a.save
  	category = Category.find(:first)
  	Post.where(:category_id => nil).each do |f|
  		f.category = category
  		f.save
  	end
  end

  def down
  end
end
