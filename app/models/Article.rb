class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :body, presence: true

  def tag_list
    tags.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").map{ |s| s.strip.downcase }.uniq
    new_or_found_tags = tag_names.map{ |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

end
