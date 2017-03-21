with File_Utils;
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
            return Make_Response (File_Utils.Read (Context & "/" & URI));
         when POST =>
            return Make_Response ("<h1>Got Post</h1>");
         when PUT =>
            return Make_Response ("<h1>Got Put</h1>");
         when DELETE =>
            return Make_Response ("<h1>Got DELETE</h1>");
         when HEAD =>
            return Make_Response ("<h1>Got HEAD</h1>");
         when others =>
            return Make_Response ("<h1>Error!</h1>");
      end case;
   end Handle_Request;
end Transaction_Handlers;
