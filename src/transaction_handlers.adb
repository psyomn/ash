with Ada.Text_IO;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.IO_Exceptions; use Ada.IO_Exceptions;

with File_Utils;
with Common_Utils;

with HTTP_Status; use HTTP_Status;
with Request_Helpers, Response_Helpers;
use Request_Helpers, Response_Helpers;

package body Transaction_Handlers is
   function Handle_Request (R : String; Context : String) return String is
      R_Type : constant Request_Type := Parse_Request_Type (R);
      URI    : constant String := Parse_Request_URI (R);
      First, Last : Positive;
   begin
      case R_Type is
         when GET =>
            Common_Utils.Empty_String_Range (Context, First, Last);
            --  TODO Sanitize URLs
            declare
               CFirst : constant Positive := Context'First;
               Path   : constant String := Context (CFirst .. First) & URI;
            begin
               return Make_Response (OK, File_Utils.Read (Path));
            end;
         when POST =>
            return Make_Response (OK, "<h1>Got Post</h1>");
         when PUT =>
            return Make_Response (OK, "<h1>Got Put</h1>");
         when DELETE =>
            return Make_Response (OK, "<h1>Got DELETE</h1>");
         when HEAD =>
            return Make_Response (OK, "<h1>Got HEAD</h1>");
         when others =>
            return Make_Response (INTERNAL_ERROR, "<h1>Error!</h1>");
      end case;
   exception
      when E : Device_Error =>
         Ada.Text_IO.Put_Line (Exception_Name (E) & " " & Exception_Message (E));
         return Make_Response (NOT_FOUND, "Resource not found");

      when E : others =>
         Ada.Text_IO.Put_Line (Exception_Name (E) & " " & Exception_Message (E));
         return Make_Response (INTERNAL_ERROR, "Something really bad happened.");
   end Handle_Request;
end Transaction_Handlers;
