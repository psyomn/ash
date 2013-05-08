-- @author Simon Symeonidis 
-- @date Fri May  3 14:53:08 EDT 2013
with Ada.Text_IO; use Ada.Text_IO; 
with Listeners;

with Ada.Strings.Unbounded;

procedure Main is 
  l1, l2 : Listeners.Listener; 
begin
  -- Init the first listener
  l1 := (Port_Number => 3000, 
         Host_Name => Ada.Strings.Unbounded.To_Unbounded_String("localhost"));
  
  l2 := (Port_Number => 6000, 
         Host_Name => Ada.Strings.Unbounded.To_Unbounded_String("localhost"));

  l1.print_info;
  l2.print_info;
  
end Main;

