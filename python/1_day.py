
# Python :
          # pyhton is a high-level ,
          # general-purpose
          # interpreted prog. lang.
          # invented in 1991 by Guido van Rossum.

# Fundamental of python :
        # 1. Data type
        # 2. Variable
        # 3. Print() and input()

# 1. Data type =>

      # (A) integer : It will store all positive or negative values.
                    # example. 12, 45 , 78 , -23

      # (B) Float : It will store decimal values.
                    # example. 12.45 , 67.90

      # (C) String : It will store values in '' , " " , ''' ''' .
                    # example. '1234' , "aman"

      # (D) Boolean : True , False.


# type() => It will check the data type of the variable.

type(12)
type(12.45)
type('1234')
type(True)

# Type casting => it will convert one data type to another data type

print(type(str(45)))

# (2). Variable => This is like a container in which we can store or assign the values.

a=56
print(a)
b='sam'
print(b)
c= 5>4
print(c)

# Types of Variable :
  # (1) Global Variable
  # (2) Local Variable


# (1). Global variable : Those are the variable who are assigned outside block of code.
                      # It will update all places where it is declared.

                      # a=10 #gloabal variable

# (2). Local variable : Those are the variable who are assigned inside the bloxk of code.

a=5
#def my_add():
b=3
c=4
d=b+c
print(d)

# (3). Print() : it will execute our query on the terminal

print(56)

# input() : It is used for get the input from user and iits default output is string format.

a=int(input("Enter first number :"))
b=int(input("Enter second number :"))
c=a+b
print(c)

# Q. wap who add two numbers

a=int(input("Enter first number :"))
b=int(input("Enter second number :"))
c=a+b
print(c)

# Q. wap who divide two numbers

a=int(input("Enter first number :"))
b=int(input("Enter second number :"))
c=a/b
print(c)

# Q. wap who multiply two numbers then add 5 and calculate the total result

a=int(input("Enter first number :"))
b=int(input("Enter second number :"))
c=a*b
d=c+5
print(d)

# Q. wap who add two numbers then divide by 5

a=int(input("Enter first number :"))
b=int(input("Enter second number :"))
c=a+b
d=c/5
print(d)

# Q. wap who print data type of element who user add


a=int(input("Enter first number :"))
print(type(a))











