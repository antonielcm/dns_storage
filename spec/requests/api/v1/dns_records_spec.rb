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

  describe "GET #index" do
    context "success" do
      it "does return anything when params are empty" do
        get "/v1/dns_records"

        expect(response).to have_http_status(200)
        expect(response.headers["Current-Page"]).to eq("1")
        expect(response.headers["Total-Pages"]).to eq("1")
        expect(json_response["total_records"]).to eq(0)
        expect(json_response["records"]).to be_empty
        expect(json_response["related_domain_names"]).to be_empty
      end

      it "does return dns records considering the given included and excluded domains" do
        populate_database()

        get "/v1/dns_records", params: {included: ["ipsum.com", "dolor.com"], excluded: ["sit.com"]}

        expect(response).to have_http_status(200)
        expect(json_response["total_records"]).to eq(2)
        expect(json_response["records"].size).to eq(2)

        related_domain_names = json_response["related_domain_names"]
        expect(related_domain_names.size).to eq(2)
        expect(related_domain_names).to match([
          a_hash_including("name" => "amet.com", "count" => 2),
          a_hash_including("name" => "lorem.com", "count" => 1)
        ])
      end
    end
  end

  private

  def populate_database()
    ip_address1 = create(:ip_address, ip: "1.1.1.1")
    ip_address2 = create(:ip_address, ip: "2.2.2.2")
    ip_address3 = create(:ip_address, ip: "3.3.3.3")
    ip_address4 = create(:ip_address, ip: "4.4.4.4")
    ip_address5 = create(:ip_address, ip: "5.5.5.5")

    domain_name1 = create(:domain_name, name: "lorem.com")
    domain_name2 = create(:domain_name, name: "ipsum.com")
    domain_name3 = create(:domain_name, name: "dolor.com")
    domain_name4 = create(:domain_name, name: "amet.com")
    domain_name5 = create(:domain_name, name: "sit.com")

    create(:dns_record, ip_address: ip_address1, domain_name: domain_name1)
    create(:dns_record, ip_address: ip_address1, domain_name: domain_name2)
    create(:dns_record, ip_address: ip_address1, domain_name: domain_name3)
    create(:dns_record, ip_address: ip_address1, domain_name: domain_name4)

    create(:dns_record, ip_address: ip_address2, domain_name: domain_name2)

    create(:dns_record, ip_address: ip_address3, domain_name: domain_name2)
    create(:dns_record, ip_address: ip_address3, domain_name: domain_name3)
    create(:dns_record, ip_address: ip_address3, domain_name: domain_name4)

    create(:dns_record, ip_address: ip_address4, domain_name: domain_name2)
    create(:dns_record, ip_address: ip_address4, domain_name: domain_name3)
    create(:dns_record, ip_address: ip_address4, domain_name: domain_name5)
    create(:dns_record, ip_address: ip_address4, domain_name: domain_name4)

    create(:dns_record, ip_address: ip_address5, domain_name: domain_name3)
    create(:dns_record, ip_address: ip_address5, domain_name: domain_name5)
  end
end
