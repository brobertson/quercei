module XHTMLContentTypeNegotiation

  XHTML_MIME_TYPE = 'application/xhtml+xml'

  # Methods for configuring a controller.
  module ControllerClassMethods
    # Configures a controller to send rendered views as application/xhtml+xml
    # instead of text/html if the client supports that content type.
    #
    # Accepts standard filter conditions (see
    # ActionController::Filters::ClassMethods for details).
    def sends_xhtml_with_correct_content_type(*filters)
      after_filter(*filters) do |controller|
        if controller.request.accepts_xhtml?
          unless controller.response.headers.keys.map(&:downcase).include?('content-type')
            controller.response.headers['Content-Type'] ||= XHTMLContentTypeNegotiation::XHTML_MIME_TYPE
          end
        end
      end
    end
  end
  
  # Methods for use by a controller.
  module ControllerMethods
    def preferred_content_type(default='text/html')
      request.accepts_xhtml? ? XHTMLContentTypeNegotiation::XHTML_MIME_TYPE : default
    end
  end
  
  # Methods for use by a request.
  module RequestMethods
    def accepts_xhtml?
      # In theory, this should also look for */*, but since that's what Internet
      # Explorer sends (which totally isn't true--it chokes on a/x+x) we have to
      # just serve it up to browsers which ask for XHTML by name. Thanks,
      # Microsoft, for releasing such a shithound browser into the world and not
      # releasing a new, less sucktastic version for a full presidential term.
      # Nice dev cycles, you utter wastes of air. *whew*
      accepts.map(&:to_s).include?(XHTMLContentTypeNegotiation::XHTML_MIME_TYPE)
    end
  end
end

module Mime #:nodoc:
  remove_const('HTML') # oh we're so polite
  HTML   = Mime::Type.new "text/html", :html
  LOOKUP['text/html'] = HTML
  LOOKUP[:html] = HTML
  XHTML  = Mime::Type.new XHTMLContentTypeNegotiation::XHTML_MIME_TYPE, :xhtml
  LOOKUP[XHTMLContentTypeNegotiation::XHTML_MIME_TYPE]    = XHTML
end

module ActionController #:nodoc:
  class Base #:nodoc:
    class << self #:nodoc:
      include XHTMLContentTypeNegotiation::ControllerClassMethods
    end
    include XHTMLContentTypeNegotiation::ControllerMethods
  end
  class AbstractRequest #:nodoc:
    include XHTMLContentTypeNegotiation::RequestMethods
  end
end
