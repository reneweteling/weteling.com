class SendgridForm
  include ActiveModel::Model

  attr_accessor :first_name, :last_name, :email
  validates :email, email: true
  validates_presence_of :first_name, :email

  def subscribe
    return false unless valid?
    result = create_recipient
    result['persisted_recipients'].each do |recipient_id|
      add_to_list recipient_id
    end
  end

  private

  def create_recipient
    data = [
      {
        email: email,
        first_name: first_name,
        last_name: last_name
      }
    ]
    do_post('contactdb/recipients', data)
  end

  def add_to_list(recipient_id)
    do_post("contactdb/lists/5977156/recipients/#{recipient_id}")
  end

  def do_post(url, data = nil)
    url = URI("https://api.sendgrid.com/v3/#{url}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["authorization"] = "Bearer #{ENV['SENDGRID_API_KEY']}"
    request["content-type"] = 'application/json'
    request.body = data.to_json if data.present?
    response = http.request(request)
    if response.body.present?
      JSON.parse response.read_body
    else
      response
    end
  end
end