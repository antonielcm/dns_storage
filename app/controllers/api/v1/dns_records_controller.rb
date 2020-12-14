class Api::V1::DnsRecordsController < ApplicationController

    def create
        @response = DnsRecordServices::CreateDnsRecordService.new(params).call()

        render_json @response
    end

    private

    def render_json(response)
      render json: response.body, status: response.success? ? 201 : 422
    end

    def dns_record_params
        params.require(:dns_records).permit(:ip, domain_names_attributes: [:name])
    end
end
