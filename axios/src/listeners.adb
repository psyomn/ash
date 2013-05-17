-- @author Simon Symeonidis
-- @date   Mon May 6 2013
-- Implementation for the listener
-- @note Also good to know why using IO Streams will not work with this sort of thing.
-- http://stackoverflow.com/questions/7540064/simple-http-server-in-ruby-using-tcpserver
-- @note Using Ada get_line for unknown input size
-- http://www.radford.edu/~nokie/classes/320/stringio.html

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

    Listening_Loop :
    while not This.Shutdown loop
      Accept_Socket(Server, Socket, Address); 
      Channel := Stream(Socket);
      declare
        CRLF         : String := ASCII.CR & ASCII.LF; 
        LF           : Character := ASCII.LF; 

        Request      : Ada.Strings.Unbounded.Unbounded_String;

        Counter      : Natural := 0;
        Chara        : Character;

        RTime_Start  : Ada.Real_Time.Time := Ada.Real_Time.Clock;
        RTime_Stop   : Ada.Real_Time.Time;
        RTime_Total  : Ada.Real_Time.Time_Span;

      begin
        -- Read the request body 
        Read_Request : 
        loop
        Character'Read(Channel, Chara);
        Ada.Strings.Unbounded.Append(
          Source   => Request, 
          New_Item => Chara);

          -- TODO try switching to counting CRLFs
          exit when
            Ada.Strings.Unbounded.To_String(
              Ada.Strings.Unbounded.Tail(
                Request, 4, ' ')) = CRLF & CRLF;
        end loop Read_Request;

        RTime_Stop  := Ada.Real_Time.Clock;
        RTime_Total := RTime_Stop - RTime_Start;

        Ada.Text_IO.Put_Line(
          Ada.Strings.Unbounded.To_String(
            Request));

        -- Handler for requests should go here.

        -- Temp response TODO broken
        String'Write(Channel, 
	  Transaction_Handlers.Handle_Request(
	    Ada.Strings.Unbounded.To_String(
              Request), Ada.Strings.Unbounded.To_String(
	        This.WS_Root_Path)));
	  
      end;
      Free(Channel);
      Close_Socket(Socket);
    end loop Listening_Loop;

  exception when E : others => 
    Ada.Text_IO.Put_Line
      (Exception_Name(E) & Exception_Message(E));

  end Listen;

end Listeners;
