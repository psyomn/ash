with Ada.Calendar;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with GNAT.Calendar.Time_IO;

package body Response_Helpers is
   function Headers return String is
   begin
      return
        "HTTP/1.0 200 OK"                             & CRLF &
        Response_Date                                 & CRLF &
        "Server: axios"                               & CRLF &
        "Content-Type: text/html; charset=iso-8859-1" & CRLF &
        "Content-Length: ";
   end Headers;

   function Response_Date return String is
      package ac  renames Ada.Calendar;
      package gct renames GNAT.Calendar.Time_IO;
      Current_Time : constant ac.Time := ac.Clock;
      Format       : constant gct.Picture_String
         := "%a, %d %B %Y %H:%M:%S EST";
      Field_Name   : constant String := "Date: ";
   begin
      return Field_Name & gct.Image (Current_Time, Format);
   end Response_Date;

   function Make_Response (S : String) return String is
      Length       : constant Positive := S'Length;
      Length_Str   : constant String   := Trim (
        Source => Positive'Image (Length),
        Side => Both
      );
   begin
      return Headers & Length_Str & CRLF & CRLF & S;
   end Make_Response;
end Response_Helpers;
