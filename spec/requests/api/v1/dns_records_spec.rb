require 'rails_helper'

RSpec.describe "DNS Records API (/dns_records)", type: :request do
  describe "POST #create" do
    context "success" do
      it "does create a dns record" do
        params = {
          "dns_records" => {
            "ip" => "192.168.0.1",
            "domain_names_attributes" => [
              {
                "name" => "twitter.com"
              }
            ]
          }
        }

        post "/v1/dns_records", params: params

        expect(response).to have_http_status(201)

        ip_address = IpAddress.find_by(id: json_response["id"])

        expect(ip_address).to be_persisted
        expect(ip_address.ip).to eq("192.168.0.1")
        expect(ip_address.domain_names.exists?(name: "twitter.com")).to be_truthy
      end
    end

    context "failure" do
      it "doesn't create a dns record when ip is nil" do
        params = {
          "dns_records" => {
            "ip" => nil,
            "domain_names_attributes" => [
              {
                "name" => "twitter.com"
              }
            ]
          }
        }

        post "/v1/dns_records", params: params

        expect(response).to have_http_status(422)
        expect(json_response["errors"]).to be_present
        expect(DnsRecord.any?()).to be_falsey
      end

      it "doesn't create a dns record when ip has invalid format" do
        params = {
          "dns_records" => {
            "ip" => "dsadsavc",
            "domain_names_attributes" => [
              {
                "name" => "twitter.com"
              }
            ]
          }
        }

        post "/v1/dns_records", params: params

        expect(response).to have_http_status(422)
        expect(json_response["errors"]).to be_present
        expect(DnsRecord.any?()).to be_falsey
      end

    it "doesn't create a dns record without domain names attributes" do
        params = {
          "dns_records" => {
            "ip" => "dsadsavc",
            "domain_names_attributes" => []
          }
        }

        post "/v1/dns_records", params: params

        expect(response).to have_http_status(422)
        expect(json_response["errors"]).to be_present
        expect(DnsRecord.any?()).to be_falsey
      end
    end
  end
end
