create or replace PROCEDURE second_procedure
as 
begin 
    dbms_output.put_line('calling second procedure & then first procedure');
    PROCEDURE_TEST;

END;
