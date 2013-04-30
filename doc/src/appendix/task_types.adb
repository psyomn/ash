with Ada.Text_IO;

procedure Task_Types is 
  task type A (Label : Character) is 
    entry Start;
  end A; 

  task body A is 
  begin
    accept Start;

    for I in Integer range 1..10 loop
      Ada.Text_IO.Put_Line(Character'Image(Label) & " is working...");
      delay 0.4;
    end loop;
  end A; 

  My_Task_01 : A(Label => 'A');
  My_Task_02 : A(Label => 'B');
  My_Task_03 : A(Label => 'C');

begin 
  My_Task_01.Start;
  My_Task_02.Start;
  My_Task_03.Start;
end Task_Types; 
