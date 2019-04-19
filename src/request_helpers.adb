--  Copyright 2019 Simon Symeonidis (psyomn)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
package body Request_Helpers is
   function Parse_Request_Type (R : String) return Request_Method is
      RF : constant Positive := R'First;
   begin
      if    R (RF .. RF + 2) = "GET"     then return GET;
      elsif R (RF .. RF + 2) = "PUT"     then return PUT;
      elsif R (RF .. RF + 3) = "POST"    then return POST;
      elsif R (RF .. RF + 3) = "HEAD"    then return HEAD;
      elsif R (RF .. RF + 4) = "TRACE"   then return TRACE;
      elsif R (RF .. RF + 5) = "DELETE"  then return DELETE;
      elsif R (RF .. RF + 6) = "OPTIONS" then return OPTIONS;
      else raise Request_Type_Error;
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
