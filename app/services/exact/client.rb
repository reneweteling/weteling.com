# require 'net/http'
# require 'cgi'
# require 'json'
# require 'terminal-table'
# require 'dotenv'
# require 'date_core'

# https://support.exactonline.com/community/s/knowledge-base#All-All-DNO-Content-restrefdocs
# https://start.exactonline.nl/docs/HlpRestAPIResources.aspx?SourceAction=10

# gem install net-http dotenv pry cgi pp json terminal-table ocran
# gem pristine cgi --version 0.4.1
# rubocop:disable Metrics/ClassLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
module Exact
  class Client
    CLIENT_ID = ENV.fetch('EXACT_CLIENT_ID')
    CLIENT_SECRET = ENV.fetch('EXACT_SECRET')
    WEBHOOK_SECRET = ENV.fetch('EXACT_WEBHOOK_SECRET')
    REDIRECT_URL = ENV.fetch('EXACT_REDIRECT_URL')
    API = 'https://start.exactonline.nl/api'

    def initialize(user)
      @user = user
    end

    def start
      authenticate if auth_token.refresh_token.nil?
      set_division
      get_transactions

      puts "\n\n\tNog een?\n\n\t1. Ja\n\t2. Nee\n\n"
      if gets.strip.to_i == 1
        start
      else
        puts "\n\nTot ziens!\n\n"
      end
    end

    def set_division
      keys = %w[Code CustomerName Description]
      rows = get_divisions
            .sort_by { |d| d['CustomerName'] + d['Description'] }
            .map { |d| d.slice(*keys).values }
      table = Terminal::Table.new title: 'Divisons (klanten)', headings: keys, rows: rows
      table.align_column(0, :right)
      puts table

      puts "\n\nKies een klant en voer het nummer hieronder in:\n"
      division = gets.strip.to_i

      exit if division.zero?

      if get_divisions.map { |d| d['Code'] }.include?(division)
        @division = division
      else
        puts "\nKlant niet gevonden, opnieuw.\n\n"
        sleep 1
        set_division
      end
    end

    def get_divisions
      @divisions = JSON.parse(File.read(File.join(Dir.pwd, 'data', 'divisions.json'))) if @cache

      # https://start.exactonline.nl/docs/HlpRestAPIResourcesDetails.aspx?name=SystemSystemAllDivisions
      attributes = 'Code,Customer,CustomerCode,CustomerName,Description'
      @divisions ||= get_results("/v1/#{@division}/system/Divisions?$select=#{attributes}")
      File.write(File.join(Dir.pwd, 'data', 'divisions.json'), JSON.pretty_generate(@divisions))
      @divisions
    end

    def get_transactions
      results = JSON.parse(File.read(File.join(Dir.pwd, 'data', 'transactions_cache.json'))) if @cache

      # https://start.exactonline.nl/docs/HlpRestAPIResourcesDetails.aspx?name=BulkFinancialTransactionLines
      filter = set_filter
      filter = filter.strip.empty? ? '' : "&$filter=#{filter}"

      attributes = 'AccountCode,AccountName,AmountDC,AmountFC,AmountVATBaseFC,AmountVATFC,AssetCode,AssetDescription,CostCenter,CostCenterDescription,CostUnit,CostUnitDescription,CreatorFullName,Currency,CustomField,Description,Division,Document,DocumentNumber,DocumentSubject,DueDate,EntryNumber,ExchangeRate,ExternalLinkDescription,ExternalLinkReference,ExtraDutyAmountFC,ExtraDutyPercentage,FinancialPeriod,FinancialYear,GLAccountCode,GLAccountDescription,InvoiceNumber,Item,ItemCode,ItemDescription,JournalCode,JournalDescription,LineType,Modified,ModifierFullName,Notes,OrderNumber,PaymentDiscountAmount,PaymentReference,Project,ProjectCode,ProjectDescription,Quantity,SerialNumber,ShopOrder,Status,Subscription,SubscriptionDescription,TrackingNumber,TrackingNumberDescription,Type,VATCode,VATCodeDescription,VATPercentage,VATType,YourRef'
      results ||= get_results("/v1/#{@division}/bulk/Financial/TransactionLines?$select=#{attributes}#{filter}")

      path = File.join(Dir.pwd, 'data', "#{@division}-transactions.json")
      File.write(path, JSON.pretty_generate(results))

      puts "\n\nBestand aangemaakt: #{path}\n\n"

      results
    end

    def set_filter
      puts "\n\n\t Pas evt een filter toe"
      puts "\n\n\t Meer over filters hier: https://www.odata.org/documentation/odata-version-2-0/uri-conventions/#QueryStringOptions - section 4.5 Filter System Query Option ($filter)"
      puts "\n\n\t Voorbeeld: 'FinancialYear gt #{Time.now.year - 2}'"
      puts "\n\n Voer hier je filter in, of laat leeg voor alles:\n\n"

      gets.strip
    end

    def authenticate(code)
      res = post('/oauth2/token', {
                  grant_type: 'authorization_code',
                  client_id: CLIENT_ID,
                  client_secret: CLIENT_SECRET,
                  redirect_uri: REDIRECT_URL,
                  code: code
                }, false)

      set_tokens(res['access_token'], res['refresh_token'])
    end

    def refresh
      return unless auth_token.expired?

      puts "\n\nRefreshing token\n\n"

      res = post('/oauth2/token', {
                  grant_type: 'refresh_token',
                  refresh_token: auth_token.refresh_token,
                  client_id: CLIENT_ID,
                  client_secret: CLIENT_SECRET
                }, false)

      set_tokens(res['access_token'], res['refresh_token'])
    end

    def authorize_url
      "#{API}/oauth2/auth?client_id=#{CLIENT_ID}&redirect_uri=#{REDIRECT_URL}&response_type=code"
    end

    def auth_token
      @auth_token || AuthToken.find_or_initialize_by(user: @user)
    end

    def get_results(path)
      res = get(path)
      page = 0
      results = parse_results(res['d']['results'])
      while res = next_page(res)
        page += 1
        puts "Page #{page}"
        results += parse_results(res['d']['results'])
      end
      results
    end

    def parse_results(results)
      results.map do |result|
        result
          .reject { |_k, v| v.is_a?(Hash) }
          .map do |k, v|
          if v.is_a? String
            v.match(%r{/Date\((\d+)\)/}) do |m|
              v = Time.at(m[1].to_i / 1000)
            end
          end
          [k, v]
        end.to_h
      end
    end

    def next_page(data)
      return unless data['d']['__next']

      path = data['d']['__next'].sub(API, '')
      get(path)
    end

    def set_tokens(access_token, refresh_token)
      return unless access_token && refresh_token

      auth_token.update!(
        access_token: access_token,
        refresh_token: refresh_token,
        expires_at: Time.zone.now + 570
      )
    end

    def get(path)
      refresh

      uri = URI("#{API}#{path}")
      req = Net::HTTP::Get.new uri
      # req['Accept'] = 'application/json'
      req['Authorization'] = "Bearer #{auth_token.access_token}"

      pp uri

      res = Net::HTTP.start(
        uri.host, uri.port,
        use_ssl: uri.scheme == 'https',
        verify_mode: OpenSSL::SSL::VERIFY_NONE
      ) do |http|
        http.request req
      end

      # pp res.code
      # pp res.body
      return res if res.content_type.include?('xml')

      parse_response(res, path)
    end

    def post(path, data, _should_refresh = true)
      # No need to do this, post is only for auth
      # refresh if should_refresh

      uri = URI("#{API}#{path}")
      req = Net::HTTP::Post.new(uri)
      req['Accept'] = 'application/json'
      # req['Authorization'] = "Bearer #{auth_token.access_token}"
      req.set_form_data(data)

      # pp uri

      res = Net::HTTP.start(
        uri.hostname, uri.port,
        use_ssl: uri.scheme == 'https',
        verify_mode: OpenSSL::SSL::VERIFY_NONE
        ) do |http|
        http.request(req)
      end

      parse_response(res, path, data)
    end

    def parse_response(response, _path, _data = nil)
      return response unless response.code == :ok

      res = JSON.parse(response.body)

      # puts JSON.pretty_generate({path: _path, res: res, data: _data})

      if res['error']
        puts "\n\nERROR\n\n"
        pp res
        puts "er ging iets mis je kan dit scherm sluiten\n\n"
      end

      res
    end
  end

end
