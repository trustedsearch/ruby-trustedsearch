require "../lib/trustedsearch"

TrustedSearch.public_key = "PUBLIC_KEY"
TrustedSearch.private_key = "PRIVATE_KEY"

#TrustedSearch.environment = 'production'

puts "Ex: directory-listings"
puts TrustedSearch.environment

TrustedSearch.api_version = 1
api = TrustedSearch::V1.new

# Ex: v1/directory-listings
#puts api.getBusinessUpdate().data.to_s

# Ex: v1/local-business
business_data = [
	{
		:externalId => 'ABC123',
		:order => {
			:onBehalfOf => 'Evo Media',
			:packages => [
				"YOUR_PACKAGE_ID"
			]
		},
		:contact => {
			:firstName => "Albert",
			:lastName => "Einstein",
			:email => "albert@trustedsearch.org",
			:phone => "5555555555"
		},
		:business => {
			:name => "Albert's Relativity Lane",
			:street => "123 Cherry Tree Lane",
			:city => "Santa Barbara",
			:state => "CA",
			:postalCode => "93041",
			:phoneTollFree =>"(800) 555-5555",
			:website => "http://www.relativitylane.com",
			:email => "info@relativitylane.com",
		}
	},
	{
		:externalId => 'ABC456',
		:order => {
			:onBehalfOf => 'Evo Media',
			:packages => [
				"YOUR_PACKAGE_ID"
			]
		},
		:contact => {
			:firstName => "Albert",
			:lastName => "Einstein",
			:email => "albert@trustedsearch.org",
			:phone => "4444444444"
		},
		:business => {
			:name => "Albert's Relativity Lane",
			:street => "456 Cherry Tree Lane",
			:city => "Santa Barbara",
			:state => "CA",
			:postalCode => "93041",
			:phoneTollFree =>"(800) 555-5555",
			:website => "http://www.relativitylane.com/mc2",
			:email => "info@relativitylane.com",
		}
	}
]

response = api.postBusiness(business_data)

# # Ex: v1/directory-listings/:uuid
uuid = response.data[0]["uuid"]
puts api.getBusinessUpdate(uuid).data.to_s



