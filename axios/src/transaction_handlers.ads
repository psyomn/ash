with 
  Request_Helpers
, Response_Helpers
, File_Utils
;

-- @author Simon Symeonidis 
-- @date   Fri May 17 
-- This encapsulates business logic of the http server (what to do
-- with each given request).
package Transaction_Handlers is 
  function Handle_Request(R : String; Context : String) return String;
end Transaction_Handlers;
