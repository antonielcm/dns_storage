require 'rails_helper'

RSpec.describe DnsRecordServices::CreateDnsRecordService, type: :model do
  describe "#call" do
    context "success" do
      it "does create a dns record, belonging to a new domain name and new ip address" do
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
        response = DnsRecordServices::CreateDnsRecordService.new(params).call()

        expect(response.success?).to be_truthy

        ip_address = IpAddress.find_by(id: response.body[:id])

        expect(ip_address).to be_persisted
        expect(ip_address.domain_names.exists?(name: "twitter.com")).to be_truthy
      end

      it "does create a dns record, belonging to an existent domain name and new ip address" do
        existent_domain_name = create(:domain_name, name: "twitter.com")
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

        response = DnsRecordServices::CreateDnsRecordService.new(params).call()

        expect(response.success?).to be_truthy

        ip_address = IpAddress.find_by(id: response.body[:id])

        expect(ip_address).to be_persisted
        expect(ip_address.domain_names.exists?(id: existent_domain_name.id)).to be_truthy
      end

      it "does create a dns record, belonging to a new domain name and existent ip address" do
        existent_ip_address = create(:ip_address, ip: "192.168.0.1")
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

        response = DnsRecordServices::CreateDnsRecordService.new(params).call()

        expect(response.success?).to be_truthy

        ip_address = IpAddress.find_by(id: response.body[:id])

        expect(ip_address.id).to eq(existent_ip_address.id)
        expect(ip_address.domain_names.exists?(name: "twitter.com")).to be_truthy
      end
    end

    context "failure" do
      it "doesn't create anything when ip address params are null or invalid" do
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

        response = DnsRecordServices::CreateDnsRecordService.new(params).call()

        expect(response.success?).to be_falsey
        expect(response.body).to have_key(:errors)
      end

      it "doesn't create anything when domain name params are null or invalid" do
        params = {
          "dns_records" => {
            "ip" => "192.168.0.1",
            "domain_names_attributes" => [
              {
                "name" => nil
              }
            ]
          }
        }

        response = DnsRecordServices::CreateDnsRecordService.new(params).call()

        expect(response.success?).to be_falsey
        expect(response.body).to have_key(:errors)
      end
    end
  end
end
