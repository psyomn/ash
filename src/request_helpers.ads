package Request_Helpers is
   Request_Type_Error : exception;

   type Request_Method is (
      GET,
      POST,
      PUT,
      DELETE,
      HEAD,
      OPTIONS,
      TRACE
   );

   function Parse_Request_Type (R : String) return Request_Method;
   function Parse_Request_URI (R : String)  return String;
end Request_Helpers;
