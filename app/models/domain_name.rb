class DomainName < ApplicationRecord
    has_many :dns_records
    has_many :ip_addresses, through: :dns_records

    validates :name, presence: true, uniqueness: true
end
