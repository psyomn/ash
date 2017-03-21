package File_Utils is
   procedure Write (File_Name : String; Contents : String);
   function Read (File_Name : String) return String;
end File_Utils;
