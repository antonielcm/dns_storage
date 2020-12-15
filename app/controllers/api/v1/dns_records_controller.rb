class Api::V1::DnsRecordsController < ApplicationController

    def create
      @result = DnsRecordServices::CreateDnsRecordService.new(params).call()

      render json: @result.body, status: @result.success? ? 201 : 422
    end

    def index
      @result = DnsRecordServices::FilterDnsRecordsService.new(params[:included], params[:excluded]).call()

      @pagy, @records = pagy(@result.records, items: 10)

      render json: {total_records: @pagy.count, records: @records, related_domain_names: @result.related_domain_names}
    end

    private

    def dns_record_params
      params.require(:dns_records).permit(:ip, domain_names_attributes: [:name])
    end
end

