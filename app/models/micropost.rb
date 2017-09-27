class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  # ファイル用の属性を追加するhas_attached_fileメソッド
  has_attached_file :image, styles: { medium: "200x150>", thumb: "50x50>" },
                    :url  => "/assets/arts/images", # 画像保存先のURL先
	                  :path => "#{Rails.root}/public/assets/images" # サーバ上の画像保存先パス
	
	#  画像の拡張子を限定するためのvalidatorを定義
  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png image/gif)




  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end
end
