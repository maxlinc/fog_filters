module FogFilters
  class RackspaceConfidential

    def initialize
      # Doing these during in initialize should avoid recording the calls to Fog,
      # because this should be called before a cassette is inserted.
      identity = Fog::Identity.new({
        :provider => 'Rackspace',
        :rackspace_api_key => ENV['RAX_API_KEY'],
        :rackspace_username => ENV['RAX_USERNAME']
      })
      tenants = identity.tenants.map(&:id)
      @tenant_id = tenants.find {|t| t.include? 'MossoCloudFS'}
      @cdn_tenant_name = tenants.find {|t| !t.include? 'MossoCloudFS'}
    end

    def before_record(interaction, cassette)
      # We definitely need to hide our credentials!
      interaction.filter!(ENV['RAX_USERNAME'], '<rackspace-username>')
      interaction.filter!(ENV['RAX_API_KEY'], '<rackspace-api-token>')

      # Let's filter out our tenants
      # Can't use the <token> format here, because it puts invalid characters in URLs
      interaction.filter!(@cdn_tenant_name, '_CDN-TENANT-NAME_')
      interaction.filter!(@tenant_id,'_TENANT_ID_')
    end

    def before_playback(interaction, cassette)
      # Some code may expect an integer here
      interaction.filter!('_TENANT_ID_', '000000')
    end
  end
end
