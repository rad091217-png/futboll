class User < ApplicationRecord
  has_many :laliga_posts
  has_many :bundesu_posts
  has_many :premier_posts
  has_many :serie_posts
  has_many :league_one_posts
  has_many :eredivisie_posts
  has_many :jupiler_posts
  has_many :premera_posts
  has_many :scotish_posts
  has_many :euro_posts
  has_many :nations_posts
  has_many :champions_posts
  has_many :europe_posts
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :laliga_post
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :microposts
  has_many :microposts, dependent: :destroy
  attr_accessor :remember_token, :activation_token, :avatar_cache
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 } # allow_nil: true
  mount_uploader :avatar, ImageUploader

  def laliga_posts
    return LaligaPost.where(user_id: self.id)
  end

  def already_liked?(laliga_post)
    self.likes.exists?(laliga_post_id: laliga_post.id)
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_temp_user(params)
    user = User.find_or_initialize_by(email: params[:email])
    user.name = params[:name]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]
    user.token = create_token
    user.expired_at = DateTime.now + 1
    return user
  end

  # アカウントを有効にする
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # ユーザーのステータスフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  def correct_user(current_user)
    if id == current_user.id
      true
    else
      # do nothing
    end
  end

  private

  # メールアドレスを小文字にする
  def downcase_email
    self.email = email.downcase
  end

  # 有効化トークンとダイジェストを作成、代入する
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def create_token
    token = nil
    loop do
      token = SecureRandom.urlsafe_base64
      break if User.find_by(token: token).nil?
    end
    return token
  end
end
