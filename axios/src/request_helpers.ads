with GNAT.Regexp;
-- @author Simon Symeonidis 
-- @date   Thu May 16 2013
package Request_Helpers is 
  type Request_Type is (HEAD, GET, POST, PUT, DELETE);

  function Parse_Request_Type(R : String) return Request_Type;
  function Parse_Request_URI(R : String)  return String;
end Request_Helpers; 
