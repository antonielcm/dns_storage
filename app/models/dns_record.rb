class DnsRecord < ApplicationRecord
  belongs_to :ip_address
  belongs_to :domain_name

  validates :ip_address, uniqueness: { scope: :domain_name }
  validates :domain_name, uniqueness: { scope: :ip_address }
end
