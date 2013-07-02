with Ada.Calendar;
with GNAT.Calendar.Time_IO;

package body Response_Helpers is 

  -- @note don't use this directly
  function Headers
  return String is 
  begin
    return 
      "Http/1.1 200 OK"                             & CRLF &
      Response_Date                                 & CRLF &
      "Server: axios"                               & CRLF &
      "Content-Type: text/html; charset=iso-8859-1" & CRLF &
      "Content-Length: ";
  end Headers;

  function Response_Date
  return String is
    package ac  renames Ada.Calendar;
    package gct renames GNAT.Calendar.Time_IO;
    Current_Time : ac.Time;
    Format       : gct.Picture_String := "%a, %d %B %Y %H:%M:%S EST";
    Field_Name   : constant String    := "Date: ";
  begin
    Current_Time := ac.Clock;
    return 
      Field_Name &
      gct.Image(Current_Time, Format);
  end Response_Date;

  -- Make the response for the browser. This function includes the headers,
  -- (including the content-length field of the body), and the message body.
  function Make_Response(S : String)
  return String is
  begin
    return
      Headers &
      Positive'Image(S'Length) & CRLF & CRLF &
      S;
  end Make_Response;


end Response_Helpers;
