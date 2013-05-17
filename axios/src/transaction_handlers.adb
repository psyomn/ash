
package body Transaction_Handlers is 
  function Handle_Request(R : String) 
  return String is
    package rh renames Response_Helpers; 
    package rr renames Request_Helpers;
    R_Type : Request_Helpers.Request_Type := 
             Request_Helpers.Parse_Request_Type(R);
  begin 
    case R_Type is 
      when rr.GET    =>
        return
	  rh.Make_Response("<h1>Got Get</h1>");
      when rr.POST   =>
        return
	  rh.Make_Response("<h1>Got Post</h1>");
      when rr.PUT    => 
        return
	  rh.Make_Response("<h1>Got Put</h1>");
      when rr.DELETE =>
        return
	  rh.Make_Response("<h1>Got DELETE</h1>");
      when rr.HEAD   =>
        return
	  rh.Make_Response("<h1>Got HEAD</h1>");
      when others =>
        return
	  rh.Make_Response("<h1>Error!</h1>"
	  & "<p> You did something very weird in order to see this</p>");
    end case;
  end Handle_Request;
end Transaction_Handlers;
