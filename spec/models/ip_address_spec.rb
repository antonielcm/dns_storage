require 'rails_helper'

RSpec.describe IpAddress, type: :model do
  it "does validate IP format" do
    expect(IpAddress.new(ip: Faker::Internet.ip_v4_address)).to be_valid
    expect(IpAddress.new(ip: Faker::Internet.ip_v6_address)).to be_valid

    expect(IpAddress.new(ip: "192.168.0.x")).not_to be_valid
    expect(IpAddress.new(ip: "abcdef")).not_to be_valid
    expect(IpAddress.new(ip: "123456")).not_to be_valid
  end
end
