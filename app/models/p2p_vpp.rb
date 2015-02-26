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
	def callMTR (uri.host, uri.port, uri.path, data)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true

		request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
		request.body = @data.to_json

		response = http.request(request)
		
	end
end
