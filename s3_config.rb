# frozen_string_literal: true

require 'aws-sdk-s3'
require 'dotenv'

Dotenv.load

module S3Config
  AWS_ACCESS_KEY_ID = ENV.fetch('AWS_ACCESS_KEY_ID', nil)
  AWS_SECRET_ACCESS_KEY = ENV.fetch('AWS_SECRET_ACCESS_KEY', nil)
  REGION = ENV.fetch('AWS_REGION', 'us-east-1')

  def self.client
    @client ||= Aws::S3::Client.new(
      access_key_id: AWS_ACCESS_KEY_ID,
      secret_access_key: AWS_SECRET_ACCESS_KEY,
      region: REGION
    )
  end
end
