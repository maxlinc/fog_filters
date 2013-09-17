module FogFilters
  class BuildingServers
    def before_record(interaction, cassette)
      # Throw away build state - just makes server.wait_for loops really long during replay
      begin
        json = ::MultiJson.load(interaction.response.body)
        server_status = json['server']['status']
        if server_status == 'BUILD'
          # Ignoring interaction because server is in BUILD state
          interaction.ignore!
        end
      rescue => e
      end
    end
  end
end
