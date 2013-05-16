-- @author Simon Symeonidis 
-- @date   Thu May 16 2013
package body Request_Helpers is 
  -- Parse the request type (get first line, see what type of http method it
  -- is and return the valid enumaration).
  function Parse_Request_Type(R : String)
  return Request_Type is 
  begin
    return HEAD;
  end Parse_Request_Type;

  -- This extracts the path requested from the first line in the http method
  -- eg:
  --
  --   GET /index.html
  --   ...
  -- 
  -- Would return a string with "index.html"
  function Parse_Request_URI(R : String)
  return String is 
  begin
    return "/";
  end Parse_Request_URI;
end Request_Helpers; 
