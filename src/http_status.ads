package HTTP_Status is
   type Code is new Positive;
   type Code_Range is range 100 .. 599;

   Bad_Code_Error : exception;

   --  Info
   CONTINUE                        : constant Code := 100;
   SWITCHING_PROTOCOLS             : constant Code := 101;

   --  Success
   OK                              : constant Code := 200;
   CREATED                         : constant Code := 201;
   ACCEPTED                        : constant Code := 202;
   NON_AUTHORITATIVE_INFORMATION   : constant Code := 203;
   NO_CONTENT                      : constant Code := 204;
   RESET_CONTENT                   : constant Code := 205;
   PARTIAL_CONTENT                 : constant Code := 206;

   --  Redirections
   MULTIPLE_CHOICES                : constant Code := 300;
   MOVED_PERMANENTLY               : constant Code := 301;
   FOUND                           : constant Code := 302;
   SEE_OTHER                       : constant Code := 303;
   NOT_MODIFIED                    : constant Code := 304;
   USE_PROXY                       : constant Code := 305;
   UNUSED                          : constant Code := 306;
   TEMPORARY_REDIRECT              : constant Code := 307;

   --  PEBKAC
   BAD_REQUEST                     : constant Code := 400;
   UNAUTHORIZED                    : constant Code := 401;
   PAYMENT_REQUIRED                : constant Code := 402;
   FORBIDDEN                       : constant Code := 403;
   NOT_FOUND                       : constant Code := 404;
   METHOD_NOT_ALLOWED              : constant Code := 405;
   NOT_ACCEPTABLE                  : constant Code := 406;
   PROXY_AUTH_REQUIRED             : constant Code := 407;
   REQUEST_TIMEOUT                 : constant Code := 408;
   CONFLICT                        : constant Code := 409;
   GONE                            : constant Code := 410;
   LENGTH_REQUIRED                 : constant Code := 411;
   PRECONDITION_FAILED             : constant Code := 412;
   REQUEST_ENTITY_TOO_LARGE        : constant Code := 413;
   REQUEST_URI_TOO_LONG            : constant Code := 414;
   UNSUPPORTED_MEDIA_TYPE          : constant Code := 415;
   REQUESTED_RANGE_NOT_SATISFIABLE : constant Code := 416;
   EXPECTATION_FAILED              : constant Code := 417;

   --  BOOM
   INTERNAL_ERROR                  : constant Code := 500;
   NOT_IMPLEMENTED                 : constant Code := 501;
   BAD_GATEWAY                     : constant Code := 502;
   SERVICE_UNAVAILABLE             : constant Code := 503;
   GATEWAY_TIMEOUT                 : constant Code := 504;
   HTTP_VERSION_NOT_SUPPORTED      : constant Code := 505;

   function Message_Of_Code (C : Code) return String;
end HTTP_Status;
