class DnsRecord < ApplicationRecord
  belongs_to :ip_address
  belongs_to :domain_name
end
