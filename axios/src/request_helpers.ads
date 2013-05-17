with GNAT.Regpat;
with Ada.Text_IO;
-- @author Simon Symeonidis 
-- @date   Thu May 16 2013
package Request_Helpers is 
  type Request_Type is (HEAD, GET, POST, PUT, DELETE, OTHER);

  function Parse_Request_Type(R : String) return Request_Type;
  function Parse_Request_URI(R : String)  return String;
  procedure Get_Word(S           : String; 
                     First, Last : out Positive; 
                     Found       : out Boolean);
end Request_Helpers; 
