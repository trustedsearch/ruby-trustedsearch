ruby-trustedsearch
==================
trustedSEARCH Ruby Gem


Full Documentation: [http://developers.trustedsearch.org](http://developers.trustedsearch.org/)

## <a id="requirement"></a>Requirements

[Ruby](http://www.ruby-lang.org/en/downloads/) 1.9 or above.


## <a id="installation"></a>Installation

Add this line to your application's Gemfile:

    gem 'trustedsearch'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trustedsearch

Once you have your credentials you can manually run rake tasks to access the the api, or you can integrate direction.

## <a id="usage"></a>Usage

The gem is designed to support all existing and future [TRUSTEDSearch API's](http://developers.trustedsearch.org) resources.

To start using the gem, you need to be given your sandbox and production public & private keys.


### API Examples

Include the required libs & set your public and private keys

```ruby

require "trustedsearch"

TrustedSearch.public_key = "PUBLIC_KEY"
TrustedSearch.private_key = "PRIVATE_KEY"
TrustedSearch.environment = "production"  #default is 'sandbox'

```


#### Get All Business for all users locations
See the [API documentation](http://developers.trustedsearch.org/#/get-business-updates) for a list of parameters for each API resource.

```ruby
api = TrustedSearch::V1.new
puts api.getBusinessUpdate().data.to_s
```

#### Get Business Updates for single location
See the [API documentation](http://developers.trustedsearch.org/#/get-business-updates) for a list of parameters for each API resource.

```ruby
api = TrustedSearch::V1.new
puts api.getBusinessUpdate(534f95e8-1de1-558f-885c-3962f22c9a28).data.to_s
```

#### Get Business Updates for single location since epoch 1380611103
See the [API documentation](http://developers.trustedsearch.org/#/get-business-updates) for a list of parameters for each API resource.

```ruby
api = TrustedSearch::V1.new
puts api.getBusinessUpdate(	534f95e8-1de1-558f-885c-3962f22c9a28, 1380611103).data.to_s
```

#### Submit New Business Listings

See the [API documentation](http://developers.trustedsearch.org/#/submitting-a-business) for a list of parameters for each API resource.

```ruby
business_data = [
	{
		:externalId => 'ABC123',
		:order => {
			:onBehalfOf => 'Sample Partner',
			:packages => [
				9,10
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
			:onBehalfOf => 'Sample Partner',
			:packages => [
				9,10
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

api = TrustedSearch::V1.new
response = api.postBusiness(business_data)

# # Ex: v1/directory-listings/:uuid
uuid = response.data[0]["uuid"]
```

### Testing

#### Testing / Simulating a change in a business listing

```ruby

uuid = '534f95e8-1de1-558f-885c-3962f22c9a28'
api = TrustedSearch::V1.new
response = api.putTestFulfillment(uuid)


```



### Rake Examples

Get all udpates in your account

	rake v1:updates[YourPublicKey,YourPrivateKey]

Get update for location 534f95e8-1de1-558f-885c-3962f22c9a28

	rake v1:updates[YourPublicKey,YourPrivateKey,534f95e8-1de1-558f-885c-3962f22c9a28]

Get update for location 534f95e8-1de1-558f-885c-3962f22c9a28 since 1380611103

	rake v1:updates[YourPublicKey,YourPrivateKey,534f95e8-1de1-558f-885c-3962f22c9a28,1380611103]

Submit a new location using JSON data in file relative path "examples/body.json"

	rake v1:submit[YourPublicKey,YourPrivateKey,"examples/body.json"]