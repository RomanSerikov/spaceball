class VkPostService
  def initialize
    @vk = VkontakteApi::Client.new
    @token = Rails.application.secrets.vk_token
    @group = Rails.application.secrets.vk_group
  end

  def post(message)
    @vk.wall.post(access_token: @token, owner_id: @group, message: message, from_group: true, v: 5.21)
  end
end
