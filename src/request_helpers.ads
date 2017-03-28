package Request_Helpers is
   type Request_Type is (HEAD, GET, POST, PUT, DELETE, TRACE, OPTIONS, OTHER);
   Request_Type_Error : Exception;

   function Parse_Request_Type (R : String) return Request_Type;
   function Parse_Request_URI (R : String)  return String;
end Request_Helpers;
