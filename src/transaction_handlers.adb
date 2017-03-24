with File_Utils;

with HTTP_Status; use HTTP_Status;
with Request_Helpers, Response_Helpers;
use Request_Helpers, Response_Helpers;

package body Transaction_Handlers is
   function Handle_Request (R : String; Context : String) return String is
      R_Type : constant Request_Type := Parse_Request_Type (R);
      URI    : constant String := Parse_Request_URI (R);
   begin
      case R_Type is
         when GET =>
            --  TODO Sanitize URLs
            return Make_Response (OK, File_Utils.Read (Context & "/" & URI));
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
      --  TODO: This should catch ENOENT instead
      when others => return Make_Response (NOT_FOUND, "Resource not found");
   end Handle_Request;
end Transaction_Handlers;
