-- @author Simon Symeonidis
-- @note thanks to: 
--   http://www.seas.gwu.edu/~mfeldman/cs2book/chap15.html
-- 
-- Simple demonstration of using task types in order to create many different 
-- tasks and launch them. 

with Ada.Text_IO;
procedure Simple_Tasks is

  task type A is 
    entry Start;
  end A; 
  task type B is 
    entry Start;
  end B;

  task body A is 
    Max_Count : constant Integer := 100;
    Counter : Integer := 0;
  begin
    accept Start;
    loop
      exit when Counter >= Max_Count;
      Ada.Text_IO.Put("apples ");
      Counter := Counter + 1;
    end loop;
  end;

  task body B is
    Max_Count : constant Integer := 200;
    Counter : Integer := 0;
  begin
    accept Start;
    loop
      exit when Counter >= Max_Count; 
      Ada.Text_IO.Put("oranges ");
      Counter := Counter + 1;
    end loop;
  end;
  
  a1, a2 : A;
  b1, b2 : B;

begin
  a1.Start;
  b1.Start;
  a2.Start;
  b2.Start; 

end Simple_Tasks;

