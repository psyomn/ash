package Response_Helpers is
   function Headers return String with Inline;
   function Response_Date return String;
   function Make_Response (S : String) return String;
   CRLF : constant String := ASCII.CR & ASCII.LF;
end Response_Helpers;
