with HTTP_Status;

package Response_Helpers is
   function Headers (Status : HTTP_Status.Code) return String with Inline;
   function Response_Date return String;
   function Make_Response
      (Status : HTTP_Status.Code; S : String) return String;
   CRLF : constant String := ASCII.CR & ASCII.LF;

private
   function First_Header_Line (Status : HTTP_Status.Code) return String;
end Response_Helpers;
