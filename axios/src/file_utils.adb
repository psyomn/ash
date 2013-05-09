-- Common read and write utils so that we separate the job of the post and put
-- method calls to this package. This is also a shorthand for pretty basic file
-- read and write operations.
--
-- Thanks to 
--  http://rosettacode.org/wiki/Read_entire_file#Ada.Direct_IO
--  http://faculty.cs.wwu.edu/reedyc/AdaResources/LectureNotes/Text_Files.html
--  http://en.wikibooks.org/wiki/Ada_Programming/Libraries/Ada.Text_IO

with Ada.Text_IO;
with Ada.Direct_IO;
with Ada.Exceptions; use Ada.Exceptions;

package body File_Utils is 

  -- Write to a file with bounded strings. Please note this will overwrite
  -- previously created files.
  procedure Write(File_Name : String; Contents : String) is 
    The_File_Mode : Ada.Text_IO.File_Mode := Ada.Text_IO.Out_File;
    The_File      : Ada.Text_IO.File_Type;
  begin
    Ada.Text_IO.Create
        (File => The_File,
	 Mode => The_File_Mode,
	 Name => File_Name);
    Ada.Text_IO.Put
        (File => The_File,
	 Item => Contents);
    Ada.Text_IO.Close(File => The_File);
    
    exception when E : others => 
      Ada.Text_IO.Put_Line
        (Exception_Name(E) & Exception_Message(E));
  end Write;

  function Read(File_Name : String)
  return String is 
    The_File_Mode : Ada.Text_IO.File_Mode := Ada.Text_IO.In_File;
    The_File      : Ada.Text_IO.File_Type;
    Size          : 
  begin 
    Ada.Text_IO.Open
      (File => The_File,
       Mode => The_File_Mode,
       Name => File_Name);


    Ada.Text_IO.Close(File => The_File);

    exception when E : others => 
      Ada.Text_IO.Put_Line
        (Exception_Name(E) & Exception_Message(E));
    return "Hello there" ;
  end Read; 

  -- Append to file by given name.
  procedure Append(File_Name : String; Contents : String) is 
  begin
    null;
    --exception when E : others => 
    --  Ada.Text_IO.Put_Line
    --    (Exception_Name(E) & Exception_Message(E));
  end Append; 

end File_Utils;
