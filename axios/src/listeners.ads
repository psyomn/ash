-- @author Simon Symeonidis
-- @date   
--
-- This is the listener for http connections to port 80. 
-- This should delegate the request to some handler, and 
-- execute the proper logic.

package Listeners is 
  procedure Print_Info(Receiver_Handle : Receiver);
  procedure Listen;
  procedure Set_Port(port:Integer);
end Listeners;
