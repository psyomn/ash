-- @author Simon Symeonidis
-- @date   
--
-- This is the listener for http connections to port 80. 
-- This should delegate the request to some handler, and 
-- execute the proper logic.

package Listener is 
  procedure Print_Info;
  procedure Listen;
  procedure Set_Port(port:Integer);
end Listener;
