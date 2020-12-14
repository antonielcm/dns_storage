class IpAddress < ApplicationRecord
    has_many :dns_records
    has_many :domain_names, through: :dns_records

    validates :ip, presence: true, uniqueness: true

    validate :ip_must_have_ipv4_format

    private

    def ip_must_have_ipv4_format
      if (IPAddr.new(ip) rescue nil).nil?
        errors.add(:ip, "must have ipv4 format")
      end
    end
end
