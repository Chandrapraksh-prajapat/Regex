declare 
x int :=10;
y int  :=0;

Begin second_procedure(x,y);
DBMS_OUTPUT.PUT_LINE('Return of value in y variable:'|| '' || y);

end;