-- @author Simon Symeonidis
-- @date   Mon May 6 2013
-- Implementation for the listener
-- @note Thanks to:
-- http://en.wikibooks.org/wiki/Ada_Programming/Libraries/Ada.Streams/Example
-- @note Also good to know why using IO Streams will not work with this sort of thing.
-- http://stackoverflow.com/questions/7540064/simple-http-server-in-ruby-using-tcpserver

package body Listeners is

  -- Print to the command line information such
  -- as host and port number
  procedure Print_Info(This : Listener) is 
  begin
    Ada.Text_IO.Put_Line("Listener Info: ");
    Ada.Text_IO.Put_Line("Port Number : " 
      & Integer'Image(This.Port_Number));
    Ada.Text_IO.Put_Line("Hostname    : " 
      & Ada.Strings.Unbounded.To_String(This.Host_Name));
    Ada.Text_IO.Put_Line("Root Dir.   : "
      & Ada.Strings.Unbounded.To_String(This.WS_Root_Path));
    Ada.Text_IO.New_Line;
  end Print_Info;

  function Tiny_Name(This : Listener)
  return String is 
    Name : String := 
      Ada.Strings.Unbounded.To_String(This.Host_Name) & "@" &
      Integer'Image(This.Port_Number);
  begin
    return Name;
  end Tiny_Name;

  -- Return the date as string, in the format specified by the RFC2616 manual.
  -- TODO need to fix this.
  function Response_Date
  return String is 
  begin
    return "Date: Tue, 14 Dec 2010 10:48:45 GMT";
  end Response_Date;

  -- Listen forever. Graceful shutdown if it receives some signal.
  procedure Listen(This : Listener) is
    Socket   : Socket_Type;
    Server   : Socket_Type;
    Address  : Sock_Addr_Type;
    Channel  : Stream_Access;
    The_Host : String := Ada.Strings.Unbounded.To_String(This.Host_Name);
  begin

    Address.Addr := Addresses (Get_Host_By_Name (The_Host), 1);
    Address.Port := Port_Type(This.Port_Number);
    Create_Socket(Server); 

    Set_Socket_Option(Server, Socket_Level, (Reuse_Address, True));
    Bind_Socket(Server, Address);
    Listen_Socket(Server); 
    -- pass to other socket.
    Ada.Text_IO.Put_Line
     ("Successfully listening on: " & 
      Port_Type'Image(Address.Port));

    while not This.Shutdown loop
      Accept_Socket(Server, Socket, Address); 
      Channel := Stream(Socket);
      declare
        CRLF         : String := ASCII.CR & ASCII.LF; 
        Data         : Ada.Streams.Stream_Element_Array(1..127);
        Offset       : Ada.Streams.Stream_Element_Count;

        Request      : Ada.Strings.Unbounded.Unbounded_String;
	Request_Size : Natural;
	Response     : String :=  
	  "Http/1.1 200 OK"                             & CRLF &
	  Response_Date                                 & CRLF &
          "Server: axios"                               & CRLF &
          "Content-Type: text/html; charset=iso-8859-1" & CRLF &
          "Content-Length: 50"                          & CRLF & CRLF &
	  
	  -- Message body
          "<html><body><h1>Hello world "  & 
	  Integer'Image(This.Port_Number) &
	  "</h1></body></html>";
	
	Counter : Natural := 0;

      begin
        -- Read the request body 
        loop
          Ada.Streams.Read(Channel.All, Data, Offset); 

	  exit when Offset = 0;

	  for I in 1 .. Offset loop
	    Ada.Strings.Unbounded.Append
	     (Source   => Request, 
	      New_Item => Character'Val(Data(I)));  
	    Ada.Text_IO.Put_Line("[" & 
	    Natural'Image(Counter)
	    & "]" & Ada.Streams.Stream_Element'Image(Data(I)) 
	    & " --> " & Character'Val(Data(I)));
	    Counter := Counter + 1;

            if Ada.Strings.Unbounded.To_String(
	      Ada.Strings.Unbounded.Tail(Request, 4, ' ')) = CRLF & CRLF then
	      Ada.Text_IO.Put_Line("Found CRLF + CRLF");
	    elsif Ada.Strings.Unbounded.To_String(
	      Ada.Strings.Unbounded.Tail(Request, 2, ' ')) = CRLF then
	      Ada.Text_IO.Put_Line("Found CRLF + CRLF"); 
	    end if;
	  end loop;

	  exit when Ada.Strings.Unbounded.To_String(
	    Ada.Strings.Unbounded.Tail(Request, 4, ' ')) 
	    = CRLF & CRLF;
	end loop;

        Ada.Text_IO.Put_Line(
	  Ada.Strings.Unbounded.To_String(Request));

	-- Handler for requests should go here.
        -- Temp response
	String'Write(Channel, Response);
	
      end;
      Close_Socket(Socket);
    end loop;

  exception when E : others => 
    Ada.Text_IO.Put_Line
      (Exception_Name(E) & Exception_Message(E));

  end Listen;

  procedure Set_Port(port : Integer) is 
  begin
    Ada.Text_IO.Put_Line("Placeholder...");
  end Set_Port;
end Listeners;
