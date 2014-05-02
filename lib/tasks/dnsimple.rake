require 'dnsimple'
require 'open-uri'

namespace :dnsimple do
  task :update do
    t = Time.now
    DNSimple::Client.username = ENV['DNSIMPLE_USERNAME']
    DNSimple::Client.password = ENV['DNSIMPLE_PASSWORD']
    dns_record = DNSimple::Record.all(DNSimple::Domain.find("willl.me")).select { |r| r.name == "pi" }.first
    ext_ip = open("http://ipecho.net/plain").read
    puts "External IP: #{ext_ip}"
    if dns_record.content != ext_ip
      puts "DNS record mismatch, updating DNSimple..."
      dns_record.content = ext_ip
      dns_record.save
      puts "DNS record saved"
    end
    puts "Completed task in #{Time.now - t} seconds"
  end
end
