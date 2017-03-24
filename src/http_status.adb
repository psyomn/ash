package body HTTP_Status is
   function Message_Of_Code (C : Code) return String is
   begin
      case C is
         when CONTINUE            => return "Continue";
         when SWITCHING_PROTOCOLS => return "Switching Protocols";

         when OK              => return "Ok";
         when CREATED         => return "Created";
         when ACCEPTED        => return "Accepted";
         when NON_AUTHORITATIVE_INFORMATION  =>
            return "Non Authoritative Information";
         when NO_CONTENT      => return "No Content";
         when RESET_CONTENT   => return "Reset Content";
         when PARTIAL_CONTENT => return "Partial Content";

         when MULTIPLE_CHOICES   => return "Multiple Choices";
         when MOVED_PERMANENTLY  => return "Moved Permanently";
         when FOUND              => return "Found";
         when SEE_OTHER          => return "See Other";
         when NOT_MODIFIED       => return "Not Modified";
         when USE_PROXY          => return "Use Proxy";
         when UNUSED             => return "Unused";
         when TEMPORARY_REDIRECT => return "Temporary Redirect";

         when BAD_REQUEST              => return "Bad Request";
         when UNAUTHORIZED             => return "Unauthorized";
         when PAYMENT_REQUIRED         => return "Payment Required";
         when FORBIDDEN                => return "Forbidden";
         when NOT_FOUND                => return "Not Found";
         when METHOD_NOT_ALLOWED       => return "Method Not Allowed";
         when NOT_ACCEPTABLE           => return "Not Acceptable";
         when PROXY_AUTH_REQUIRED      => return "Proxy Auth Required";
         when REQUEST_TIMEOUT          => return "Request Timeout";
         when CONFLICT                 => return "Conflict";
         when GONE                     => return "Gone";
         when LENGTH_REQUIRED          => return "Length Required";
         when PRECONDITION_FAILED      => return "Precondition Failed";
         when REQUEST_ENTITY_TOO_LARGE => return "Request Entity Too Large";
         when REQUEST_URI_TOO_LONG     => return "Request Uri Too Long";
         when UNSUPPORTED_MEDIA_TYPE   => return "Unsupported Media Type";
         when REQUESTED_RANGE_NOT_SATISFIABLE =>
            return "Requested Range Not Satisfiable";
         when EXPECTATION_FAILED       => return "Expectation Failed";

         when INTERNAL_ERROR      => return "Internal Error";
         when NOT_IMPLEMENTED     => return "Not Implemented";
         when BAD_GATEWAY         => return "Bad Gateway";
         when SERVICE_UNAVAILABLE => return "Service Unavailable";
         when GATEWAY_TIMEOUT     => return "Gateway Timeout";
         when HTTP_VERSION_NOT_SUPPORTED =>
            return "Http Version Not Supported";
         when others => raise Bad_Code_Error;
      end case;
   end Message_Of_Code;
end HTTP_Status;
