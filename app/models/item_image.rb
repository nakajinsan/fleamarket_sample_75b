class ItemImage < ApplicationRecord
  mount_uploader :url, ImageUploader
  belongs_to :item
end