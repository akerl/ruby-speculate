require 'aws-sdk'

module Speculate
  ##
  # Base class for assumptions
  class Assumption
    include Speculate::Formatters

    def initialize(params = {})
      @options = params
    end

    def creds
      @creds ||= assumed_role.credentials
    end

    def url
      @url ||= console.url
    end

    def logout_url
      @logout_url ||= console.logout_url
    end

    private

    def assumed_role
      @assumed_role ||= client.assume_role(
        role_arn: role_arn,
        role_session_name: role_session_name,
        **mfa_args
      )
    end

    def client
      @client ||= Aws::STS::Client.new(local_config)
    end

    def console
      @console ||= Speculate::Console.new(creds: creds)
    end

    def mfa
      @mfa ||= @options[:mfa]
    end

    def mfa_device
      @mfa_device ||= local_identity.arn.sub('user/', 'mfa/')
    end

    def mfa_args
      return {} unless mfa
      { serial_number: mfa_device, token_code: mfa }
    end

    def role_name
      @role ||= @options[:role_name] || raise('No role_name supplied')
    end

    def role_arn
      @role_arn ||= "arn:aws:iam::#{target_account_id}:role/#{role_name}"
    end

    def role_session_name
      @role_session_name ||= local_user_name
    end

    def target_account_id
      @target_account_id ||= @options[:account_id] || local_account_id
    end

    def local_account_id
      @local_account_id ||= local_identity.account
    end

    def local_user_name
      @local_user_name ||= local_identity.arn.split(':').last.tr('/', '_')
    end

    def local_identity
      @local_identity ||= client.get_caller_identity
    end

    def local_config
      @local_config ||= @options[:creds] || {}
    end
  end
end
