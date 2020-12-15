ip_address = IpAddress.new(ip: "1.1.1.1")
ip_address.domain_names = [DomainName.find_or_initialize_by(name: "lorem.com"), DomainName.find_or_initialize_by(name: "ipsum.com"), DomainName.find_or_initialize_by(name: "dolor.com"), DomainName.find_or_initialize_by(name: "amet.com")]
ip_address.save!

ip_address = IpAddress.new(ip: "2.2.2.2")
ip_address.domain_names = [DomainName.find_or_initialize_by(name: "ipsum.com")]
ip_address.save!

ip_address = IpAddress.new(ip: "3.3.3.3")
ip_address.domain_names = [DomainName.find_or_initialize_by(name: "ipsum.com"), DomainName.find_or_initialize_by(name: "dolor.com"), DomainName.find_or_initialize_by(name: "amet.com")]
ip_address.save!

ip_address = IpAddress.new(ip: "4.4.4.4")
ip_address.domain_names = [DomainName.find_or_initialize_by(name: "ipsum.com"), DomainName.find_or_initialize_by(name: "dolor.com"), DomainName.find_or_initialize_by(name: "sit.com"), DomainName.find_or_initialize_by(name: "amet.com")]
ip_address.save!

ip_address = IpAddress.new(ip: "5.5.5.5")
ip_address.domain_names = [DomainName.find_or_initialize_by(name: "dolor.com"), DomainName.find_or_initialize_by(name: "sit.com")]
ip_address.save!
