-- Explain IN, OUT and INOUT in procedures.
--For example:


create or replace procedure pin( x in number )
as
--IN parameter can read value but can not be overwritten. If I attempt to modify an IN

begin
dbms_output.put_line( 'x = ' || x );
--x := 55;
end;
/


create or replace procedure pout( x  out number )
as
--IN OUT parameter can read value and can be overwritten.
--
begin
dbms_output.put_line( 'x = ' || x );
--x := 55;
end;
/


create or replace procedure pinout( x in out number )
as
--An OUT parameter can read value and can be overwritten however an OUT only parameter is always assigned NULL on the way into the routine.

begin
dbms_output.put_line( 'x = ' || x );
--x := 55;
end;
/

exec pin(50);
exec pout(50);
exec pinout(x);







DECLARE
    a NUMBER;
    b NUMBER;
    c NUMBER;

    PROCEDURE findmin (x IN NUMBER, y IN NUMBER, z OUT NUMBER ) IS
    BEGIN
        IF x < y THEN
            z := x;
        ELSE
            z := y;
        END IF;
    END;

BEGIN
    a := 23;
    b := 45;
    findmin(a, b, c);
    dbms_output.put_line(' Minimum of (23, 45) : ' || c);
END;
/



DECLARE
    a NUMBER;

    PROCEDURE squarenum (
        x IN OUT NUMBER
    ) IS
    BEGIN
        x := x * x;
    END;

BEGIN
    a := 23;
    squarenum(a);
    dbms_output.put_line(' Square of (23): ' || a);
END;
/




DECLARE 
   -- Global variables  
   num1 number := 95;  
   num2 number := 85;  
BEGIN  
   dbms_output.put_line('Outer Variable num1: ' || num1); 
   dbms_output.put_line('Outer Variable num2: ' || num2); 
   DECLARE  
      -- Local variables 
      num1 number := 195;  
      num2 number := 185;  
   BEGIN  
      dbms_output.put_line('Inner Variable num1: ' || num1); 
      dbms_output.put_line('Inner Variable num2: ' || num2); 
   END;  
END; 
/ 


select  1 from piplinelog;



SELECT * FROM   piplinelog
--ORDER BY COLUMNNAME -OPTIONAL          
OFFSET 1 ROWS FETCH NEXT 2 ROWS ONLY;

select t.*,  rank() over (order by incol desc) from piplinelog t;

