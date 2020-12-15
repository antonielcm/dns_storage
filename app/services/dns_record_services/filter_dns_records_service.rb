module DnsRecordServices
  class FilterDnsRecordsService
    def initialize(included, excluded)
      @included_domain_names = DomainName.where(name: included)
      @excluded_domain_names = DomainName.where(name: excluded)
    end

    def call
      excluded_ip_addresses_ids = DnsRecord.where(domain_name: @excluded_domain_names).pluck(:ip_address_id).uniq()
      dns_records = DnsRecord.where.not(ip_address: excluded_ip_addresses_ids).where(domain_name: @included_domain_names)

      included_ip_addresses_ids = dns_records
                                            .group(:ip_address_id)
                                            .count()
                                            .filter {|key, value| value == @included_domain_names.count}
                                            .keys()

      records = IpAddress.where(id: included_ip_addresses_ids)

      related_domain_names = DnsRecord
                                    .joins(:domain_name)
                                    .where(ip_address: included_ip_addresses_ids)
                                    .where.not(domain_name: @included_domain_names)
                                    .group("domain_names.name")
                                    .count()
                                    .map {|key, value| {name: key, count: value}}

      OpenStruct.new(records: records, related_domain_names: related_domain_names)
    end
  end
end
