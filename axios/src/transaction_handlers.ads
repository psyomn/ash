with 
  Request_Helpers
, Response_Helpers
;

-- @author Simon Symeonidis 
-- @date Fri May 17 15:55:22 EDT 2013
-- This encapsulates business logic of the http server (what to do
-- with each given request).
package Transaction_Handlers is 
  function Handle_Request(R : String) return String;
end Transaction_Handlers;
