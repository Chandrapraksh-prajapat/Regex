create or REPLACE PROCEDURE second_PROCEDURE(salary in out int)
as
begin
     dbms_output.put_line('Procedure input value: '|| ''||  salary);
     salary :=salary+500;
end;