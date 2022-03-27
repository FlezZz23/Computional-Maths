syms f(x);
f(x)=exp(1.5*x);
flag=1;
while flag==1
m1=input("Введите число значений в таблице m+1: ");
m=m1-1;
a=input("Введите начальную точку а: ");
h=input("Введите шаг h: ");
for i=0:m
    rez(i+1,1)=a+i*h;
    rez(i+1,2)=double(subs(f,rez(i+1,1)));
end
%Вычисление 1-ой производной
rez(1,3)=(-3*rez(1,2)+4*rez(2,2)-rez(2,2))/(2*h);
for i=2:m
    rez(i,3)=(rez(i+1,2)-rez(i-1,2))/(2*h);
end
rez(m+1,3)=(3*rez(m+1,2)-4*rez(m,2)+rez(m-1,2))/(2*h);
%Вычисление абсолютной и относительной погрешности
for i=1:m+1
    rez(i,4)=abs(rez(i,3)-1.5*rez(i,2));
    rez(i,5)=rez(i,4)/rez(i,3);
end

for i=2:m
    rez(i,6)=(rez(i+1,2)-2*rez(i,2)+rez(i-1,2))/(h*h);
    rez(i,7)=abs(rez(i,6)-1.5*1.5*rez(i,2));
    rez(i,8)=rez(i,7)/rez(i,6);
end
disp(rez);
while (1>0)
flag=input("Введите 1, если хотите ввести новые значения и введите 0, если хотите выйти из программы: ");
if (flag~=0)&(flag~=1)
    disp("Введено неверное значение");
end
if (flag==0)|(flag==1)
    break;
end
end
end