module DnsRecordServices
  class CreateDnsRecordService
    def initialize(params)
      @ip_address = IpAddress.find_or_initialize_by(ip: params.dig("dns_records", "ip"))
      @domains = params.dig("dns_records", "domain_names_attributes")
    end

    def call
      begin
        ActiveRecord::Base.transaction do
          @ip_address.domain_names << build_domain_names
          @ip_address.save!
        end

        successful_response
      rescue
        error_response
      end
    end

    private

    def build_domain_names
      @domains.map { |domain| DomainName.find_or_initialize_by(name: domain["name"]) }
    end

    def successful_response
      OpenStruct.new(success?: true, body: {id: @ip_address.id})
    end

    def error_response
      OpenStruct.new(success?: false, body: {errors: @ip_address.errors.full_messages})
    end
  end
end
