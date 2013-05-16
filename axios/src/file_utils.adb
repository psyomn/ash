-- Common read and write utils so that we separate the job of the post and put
-- method calls to this package. This is also a shorthand for pretty basic file
-- read and write operations.
--
-- Thanks to 
--  http://rosettacode.org/wiki/Read_entire_file#Ada.Direct_IO
--  http://rosettacode.org/wiki/Read_a_file_line_by_line#Ada
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

  -- This will read the full contents of a given file.
  -- Read a file by name, and then return the file text contents, lines
  -- delimited by a ASCII.LF
  function Read(File_Name : String)
  return String is 
    The_File_Mode : Ada.Text_IO.File_Mode := Ada.Text_IO.In_File;
    The_File      : Ada.Text_IO.File_Type;
    Return_Value  : Ada.Strings.Unbounded.Unbounded_String;
    Contents      : Ada.Strings.Unbounded.Unbounded_String;
  begin 
    Ada.Text_IO.Open
      (File => The_File,
       Mode => The_File_Mode,
       Name => File_Name);

    while not Ada.Text_IO.End_Of_File (The_File) loop  
      declare
        Line : String := Ada.Text_IO.Get_Line(The_File);
      begin 
        Ada.Strings.Unbounded.Append(Source => Contents, New_Item => Line(1..Line'Last));
        Ada.Strings.Unbounded.Append(Source => Contents, New_Item => ASCII.LF);
      end;
    end loop;

    Ada.Text_IO.Close(File => The_File);
    return Ada.Strings.Unbounded.To_String(Contents) ;

    return Ada.Strings.Unbounded.To_String(Return_Value) ;
  end Read; 

  -- Append to file by given name.
  -- TODO 
  procedure Append(File_Name : String; Contents : String) is 
  begin
    null;
    --exception when E : others => 
    --  Ada.Text_IO.Put_Line
    --    (Exception_Name(E) & Exception_Message(E));
  end Append; 

end File_Utils;
