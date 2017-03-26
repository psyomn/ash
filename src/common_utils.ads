package Common_Utils is
   function Integer_To_Trimmed_String (I : Integer) return String
      with Inline;

   function Header_String (Field : String; Value : String) return String
      with Inline;

   function Header_String (Field : String; Value : Integer) return String
      with Inline;

   procedure Empty_String_Range
     (S : String;
      First : out Positive;
      Last : out Positive)
      with Inline;
end Common_Utils;
