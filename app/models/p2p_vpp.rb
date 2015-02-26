class P2pVpp < ActiveRecord::Base
	def ACNL(SystemsTraceAuditNumber, RetrievalReferenceNumber, AcquiringBin, AcquirerCountryCode, PrimaryAccountNumber)
		@stan = SystemsTraceAuditNumber
		@rrn = strftime([format='%y']).[2]
		@bin = AcquiringBin.[0-6]
		@country = AcquirerCountryCode ? 980
		@cardA = PrimaryAccountNumber
		@data = %w(
			"SystemsTraceAuditNumber": @stan,
			"RetrievalReferenceNumber": @rrn,
			"AcquiringBin": @bin,
			"AcquirerCountryCode": @country,
			"PrimaryAccountNumber": @cardA
			)
	end
	def ACNV (CardExpiryDate, CardCvv2Value, Avs, CardAcceptor)
		@expire = CardExpiryDate
		@cvv = CardCvv2Value
		@avs = JSON.parse(Avs)
		@acceptorA = JSON.parse(CardAcceptor)
		@data = %w(
			"SystemsTraceAuditNumber": @stan,
			"RetrievalReferenceNumber": @rrn,
  			"AcquiringBin": @bin,
  			"AcquirerCountryCode": @country,
			"PrimaryAccountNumber": @cardA,
			"CardExpiryDate": @expire,
			"CardCvv2Value": @cvv,
			"Avs": @avs
			"CardAcceptor":@acceptorA
			)
	def AFT (SenderCurrencyCode, Amount, Surcharge, TransactionIdentifier, ForeignExchangeFeeTransaction, BusinessApplicationID, MagneticStripeData, PointOfServiceData, PointOfServiceCapability)
		@currency = SenderCurrencyCode
		@amount = Amount
		@surcharge = Surcharge
		@id = TransactionIdentifier
		@exchange_fee = ForeignExchangeFeeTransaction
		@app_id = BusinessApplicationID
		@magnetic = MagneticStripeData
		@psd = JSON.parse(PointOfServiceData)
		@psc = JSON.parsePointOfServiceCapability)
		@data = %w(
			"SystemsTraceAuditNumber": @stan,
  			"RetrievalReferenceNumber": @rrn,
			"DateAndTimeLocalTransaction": @",
			"AcquiringBin": @bin,
			"AcquirerCountryCode": @country,
			"SenderPrimaryAccountNumber": @cardA,
			"SenderCardExpiryDate": @expire,
			"SenderCurrencyCode": @currency,
			"Amount": @amount,
			"Surcharge": @surcharge,
			"TransactionIdentifier": @id,
			"ForeignExchangeFeeTransaction": @exchange_fee,
			"BusinessApplicationID": @app_id,
			"CardAcceptor": @acceptorA,
			"MagneticStripeData": @magnetic,
			"PointOfServiceData": @psd,
			"PointOfServiceCapability": @psc
  			)
	end
	def OCT (RecipientCardPrimaryAccountNumber, SourceOfFund, CardAcceptor)
		@cardB = RecipientCardPrimaryAccountNumber
		@source = SourceOfFund
		@acceptorB = CardAcceptor
		@data = %w(
			"SystemsTraceAuditNumber": @stan,
			"RetrievalReferenceNumber": @rrn,
			"DateAndTimeLocalTransaction": DateTime.now,
			"AcquiringBin": @bin,
			"AcquirerCountryCode": @country,
			"SenderReference": null,
			"SenderAccountNumber": @cardA,
			"SenderCountryCode": @country,
			"TransactionCurrency": @currency,
			"SenderName": @acceptorA[Name],
			"SenderAddress": @avs[Street],
			"SenderCity": @acceptorA[City],
			"SenderStateCode": @acceptorA[State],
			"RecipientCardPrimaryAccountNumber": @cardB,
			"Amount": @amount,
			"BusinessApplicationID": @app_id,
			"TransactionIdentifier": @app_id,
			"SourceOfFunds": @source
			"CardAcceptor": @acceptorB			
			)		
	end
	def AFTR (SystemsTraceAuditNumber)
		@stra = SystemsTraceAuditNumber
		@data = %w(
			"SystemsTraceAuditNumber": @stra,
			"RetrievalReferenceNumber": @rrn ? rrn.find[@stra],
			"TransactionIdentifier": @id ? id.find[@stra],
			"DateAndTimeLocalTransaction": DateTime.now,
			"AcquiringBin": @bin ? bin.find[@stra],
			"AcquirerCountryCode": @country ? country.find[@stra],
			"SenderPrimaryAccountNumber": @cardA ? country.find[@stra],
			"SenderCardExpiryDate": @expire ? expire.find[@stra] ? null,
			"SenderCurrencyCode": @currency ? currency.find[@stra],
			"Amount": @amount ? amount.find[@stra],
			"Surcharge": @surcharge ? surcharge.find[@stra],
			"ForeignExchangeFeeTransaction": @exchange_fee ? exchange_fee.find[@stra],
			"OriginalDataElements": @response,
			"CardAcceptor": @acceptorA,
			"PointOfServiceData": @psd,
			"PointOfServiceCapability": @psc
			)
	end
	def callVPP (uri.host, uri.port, uri.path, data)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true

		request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
		request.body = @data.to_json

		response = http.request(request)
		
	end
end
