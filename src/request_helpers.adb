with Ada.Text_IO; use Ada.Text_IO;

package body Request_Helpers is
   function Parse_Request_Type (R : String) return Request_Type is
      RF : constant Positive := R'First;
   begin
      if    R (RF .. RF + 2) = "GET"     then return GET;
      elsif R (RF .. RF + 2) = "PUT"     then return PUT;
      elsif R (RF .. RF + 3) = "POST"    then return POST;
      elsif R (RF .. RF + 3) = "HEAD"    then return HEAD;
      elsif R (RF .. RF + 4) = "TRACE"   then return TRACE;
      elsif R (RF .. RF + 5) = "DELETE"  then return DELETE;
      elsif R (RF .. RF + 6) = "OPTIONS" then return OPTIONS;
      else return GET;
      end if;
   end Parse_Request_Type;

   function Parse_Request_URI (R : String) return String is
      First : Positive := 3;
      Last  : Positive;
      Blank : constant Character := ' ';
   begin
      for I in Positive range R'Range loop
         if R (I) = Blank then
            First := I + 1;
            exit;
         end if;
      end loop;

      for I in Positive range First .. R'Last loop
         if R (I) = Blank then
            Last := (if I > 1 then I - 1 else I);
            exit;
         end if;
      end loop;
      return R (First .. Last);
   end Parse_Request_URI;
end Request_Helpers;
