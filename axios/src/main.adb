-- @author Simon Symeonidis 
-- @date Fri May  3 14:53:08 EDT 2013
with Ada.Text_IO; use Ada.Text_IO; 
with Ada.Strings.Unbounded;

-- user
with Listeners, File_Utils;
procedure Main is 

  -- Pointers so we pass to the task types.
  type Listener_Access is access Listeners.Listener;

  task type Launch_Listener(L : Listener_Access) is
    entry Start; 
    entry Stop;
  end Launch_Listener; 

  task body Launch_Listener is 
  begin
    accept Start;
    L.Print_Info;
    L.Listen;
    accept Stop;
  end Launch_Listener;

  -- listeners. Notice the '
  l1 : Listener_Access := 
    new Listeners.Listener'(Port_Number  => 3000, 
    Host_Name    => Ada.Strings.Unbounded.To_Unbounded_String("localhost"),
    Shutdown     => false,
    WS_Root_Path => Ada.Strings.Unbounded.To_Unbounded_String("./www1/"));
  
  l2 : Listener_Access := 
    new Listeners.Listener'(Port_Number  => 8000, 
    Host_Name    => Ada.Strings.Unbounded.To_Unbounded_String("localhost"),
    Shutdown     => false,
    WS_Root_Path => Ada.Strings.Unbounded.To_Unbounded_String("./www2/"));
  
  -- listener tasks
  lt1 : Launch_Listener(L => l1);
  lt2 : Launch_Listener(L => l2);

begin
  -- Do whatever
  lt1.Start;
  lt2.Start;

  -- On Graceful end 
  lt1.Stop;
  lt2.Stop;
end Main;

