with GNAT.Regpat;

package body Request_Helpers is
   function Parse_Request_Type (R : String) return Request_Type is
      First, Last : Positive;
      Found       : Boolean;
   begin
      Get_Word (R, First, Last, Found);

      if R (First .. Last) = "GET"       then return GET;
      elsif R (First .. Last) = "POST"   then return POST;
      elsif R (First .. Last) = "PUT"    then return PUT;
      elsif R (First .. Last) = "HEAD"   then return HEAD;
      elsif R (First .. Last) = "DELETE" then return DELETE;
      else return GET;
      end if;
   end Parse_Request_Type;

   function Parse_Request_URI (R : String) return String is
      First, Last : Positive;
      Found : Boolean;
   begin
      Get_Word (R, First, Last, Found);
      Get_Word (R (Last + 1 .. R'Last), First, Last, Found);
      --  Called twice, because the second 'word' is the uri in the request
      --  header.

      if Found then
         return R (First .. Last);
      end if;

      return "uri not found.";
   end Parse_Request_URI;

   procedure Get_Word
     (S           : String;
      First, Last : out Positive;
      Found       : out Boolean) is
      Pattern     : constant String := "(\S+)";
      Compiled    : constant GNAT.Regpat.Pattern_Matcher :=
         GNAT.Regpat.Compile (Pattern);
      Match_Array : GNAT.Regpat.Match_Array (0 .. 1);
   begin
      GNAT.Regpat.Match (Compiled, S, Match_Array);
      Found := not GNAT.Regpat."="(Match_Array (1), GNAT.Regpat.No_Match);

      if Found then
         First := Match_Array (1).First;
         Last  := Match_Array (1).Last;
      end if;
   end Get_Word;
end Request_Helpers;
