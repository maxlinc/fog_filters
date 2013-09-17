require 'spec_helper'
require 'fog'

class MyFogHelper
    def initialize(username, api_key)
        @username = username
        @api_key = api_key
    end
    
    def show_server name
      service.servers.get name
    end

    def create_server
        flavor = service.flavors.first
        # pick the first Ubuntu image we can find
        image = service.images.find {|image| image.name =~ /Ubuntu/}
        server_name = "test_server"
        
        server = service.servers.create :name        => server_name,
                                        :flavor_id   => flavor.id,
                                        :image_id    => image.id
        server.wait_for(600, 5) {
            ready?
        }
        server
    end
    
    def service
        @service ||= Fog::Compute.new({
            :provider           => 'rackspace',
            :rackspace_username => @username,
            :rackspace_api_key  => @api_key,
            :version            => :v2,
            :rackspace_region   => :ord})
    end
end

describe Fog do
    let(:username) { ENV['RAX_USERNAME'] }
    let(:api_key) { ENV['RAX_API_KEY'] }
    let (:helper) { MyFogHelper.new(username, api_key) }

    it "should show a server", :vcr => true do
      helper.show_server 'my_server'
    end

    it "should create a server", :vcr => true do
        server = helper.create_server()
        server.state.should eq('ACTIVE')
    end
end