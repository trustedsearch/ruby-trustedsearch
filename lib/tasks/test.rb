require "../trustedsearch.rb"

TrustedSearch.public_key = "0e2e66593bd4e7423ab83b2ded17acfa"
TrustedSearch.private_key = "pakaThe3rupHuprEnupraCha"
TrustedSearch.environment = "sandbox"  #default is 'sandbox'

begin
	api = TrustedSearch::V1.new
	puts api.getBusinessUpdate().data.to_s
	puts "hi"
rescue Exception => e
	puts "error"
	puts e.message()	
end
