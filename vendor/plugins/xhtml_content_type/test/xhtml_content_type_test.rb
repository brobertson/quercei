require 'rubygems'
require_gem 'rails'
require 'action_controller/test_process'
require 'test/unit'
require 'lib/xhtml_content_type'


ActionController::Routing::Routes.draw do |map|
  map.connect ':controller/:action/:id'
end

# The base class for testing.
class ApplicationController < ActionController::Base
  def rescue_action(e) raise e end; 
  
  def index
    render :text => "Welcome to WonderPuppy's Happy Magic Pony Palace!"
  end
  
  def secret_ferret_brigade
    render :text => "Congratulations! You're obviously a member of the Secret Ferret Brigade!"
  end
  
  def magic_xml_castle
    render :text => "I'm broken XML! Oh noes!", :content_type => :xml
  end
  
  def explicitly_xhtml
    render :text => 'Je suis HTML.', :content_type => :xhtml
  end
  
  def explicitly_html
    render :text => 'Je suis HTML.', :content_type => :html
  end
  
  
  def with_respond_to
    respond_to do |wants|
      wants.html {render :text => 'Ich ben ein HTML'}
      wants.js {render :text => 'Ich ben ein ECMA', :content_type => :js}
    end
  end
end

# Handles all actions.
class ConditionlessController < ApplicationController
  sends_xhtml_with_correct_content_type
end

class XhtmlContentTypeTest < Test::Unit::TestCase

  def setup
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  # There's enough jiggery-pokery with the Rails internals here that I want to 
  # make sure this won't eat some kind of horrible, orphan-killing,
  # false-negative-generating flaming death while my back's turned. Call me
  # paranoid; I dare you.
  def test_make_sure_the_testing_structure_works
    make_controller :application
    get :index
    assert_response :success
    get :secret_ferret_brigade
    assert_response :success
    get :magic_xml_castle
    assert_response :success
    get :explicitly_xhtml
    assert_response :success
    get :explicitly_html
    assert_response :success
  end
  
  def test_without_conditions
    make_controller :conditionless
    get :index
    assert_response :success
    assert_content_type 'application/xhtml+xml'

    get :secret_ferret_brigade
    assert_response :success
    assert_content_type 'application/xhtml+xml'

    get :magic_xml_castle
    assert_response :success
    assert_content_type :xml # shouldn't change an already-specified content type
  end
  
  def test_ancient_client
    make_controller :conditionless
    get_with_accepts :index, 'text/html'
    assert_content_type 'text/html'
    
    # "Wait a minute, I'm not ancient, I'm Internet Explorer 6!"
    make_controller :conditionless
    get_with_accepts :index, '*/*'
    assert_content_type 'text/html'
    # "Now I remember: I'm a total joke, and a blemish on the ass of the internet."
  end
  
  def test_explicit_content_types
    make_controller :conditionless
    get :explicitly_xhtml
    assert_content_type :xhtml
    get :explicitly_html
    assert_content_type :html
  end
  
  def test_mime_lookup
    const = Mime::HTML
    lookup = Mime::Type.lookup "text/html"
    assert_equal const, lookup
  end
  
  def test_with_respond_to
    make_controller :conditionless

    get_with_accepts :with_respond_to, 'text/html'
    assert_content_type 'text/html'

    get_with_accepts :with_respond_to, 'application/xhtml+xml,*/*'
    assert_content_type "application/xhtml+xml"

    get_with_accepts :with_respond_to, 'text/javascript'
    assert_content_type :js

    xhr :get, :with_respond_to
    assert_content_type :js
end
  
private

  alias :get_with_default_accepts :get
  
  def get(*options)
    @request.env['HTTP_ACCEPT'] = '*/*,application/xhtml+xml'
    get_with_default_accepts *options
  end

  # Since we're testing different controllers, here's a little sump'en-sump'en
  # to make my life easier. Also? It looks cooler.
  def make_controller(klass)
    @controller = eval("#{klass.to_s.camelize}Controller").new
  end
  
  def assert_content_type(content_type)
    # nil turns into text/html once it hits Cgi#header, so it counts as text/html
    assert_equal content_type == 'text/html' ? nil : content_type, @response.headers['Content-Type']
  end
  
  def get_with_accepts(action, accepts)
    @request.env['HTTP_ACCEPT'] = accepts
    get_with_default_accepts action
  end

end
