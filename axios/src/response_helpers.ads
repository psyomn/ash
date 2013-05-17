-- @author Simon Symeonidis
-- @date   Fri May 17 00:23:45 EDT 2013
-- This is a helper for forming the responses.
package Response_Helpers is
  function Headers return String;
  function Response_Date return String;
  function Make_Response(S : String) return String;
private 
  CRLF : constant String := ASCII.CR & ASCII.LF;
end Response_Helpers;
