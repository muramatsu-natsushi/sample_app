class AddAttachmentImageToMicroposts < ActiveRecord::Migration[5.1]
  def self.up
    change_table :microposts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :microposts, :image
  end
end
