syms f(x);
syms pn(x);
disp("Решается задача обратного интерполирования. Вариант 5, функция для интерполяции: ");
f(x)=1-exp(-2*x)
m1=input("Введите число значений в таблице m+1: ");
m=m1-1;
A=input("Введите концы отрезка [a, b], из которого выбираются узлы интерполяции: ");
for i=0:m
tabl(i+1,1)=A(1)+(A(2)-A(1))/m*i;
tabl(i+1,2)=double(subs(f,tabl(i+1,1)));
end
disp("Построенная таблица значений: ");
disp(tabl(:,:));

%%
flag=1;
while flag==1
F=input("Введите F - значение функции: ");
for i=1:m+1 
    tabl(i,3)=abs(tabl(i,2)-F);
end
tabl_sort=sortrows(tabl,3);
tabl_sort(:,3)=[];
tabl(:,3)=[];
while (1>0)
    n=input("Введите n‒степень интерполяционного многочлена, который будет построен для того, чтобы найти значение аргумента при котором f(x)=F: ");
    if (n>m)
        disp("Введено недопустимое значение n");
    else
        break;
    end
end
disp("Первый способ: интерполирование по значениям f(x)");
tabl_sort(:,3)=tabl_sort(:,2);
tabl_sort(:,2)=tabl_sort(:,1);
tabl_sort(:,1)=tabl_sort(:,3);
tabl_sort(:,3)=[];
disp("Отсортированная и перевернутая таблица значений: ");
disp(tabl_sort(:,:));
disp("Интерполяционный многочлен в форме Ньютона по значениям f(x):");
pn=newton(tabl_sort, n)
X=double(subs(pn,F));
disp("Значение x при котором f(x)=F: "+ num2str(X));
u2=abs(F - double(subs(f,X)));
disp("Абсолютная погрешность: "+ num2str(u2));
disp("Второй способ: интерполирование по значениям x и решение уравнения f(x)=F");
for i=1:m+1 
    tabl(i,3)=abs(tabl(i,2)-X);
end
disp("Отсортированная таблица значений (отсортировано по значению Х из 1-го способа): ");
tabl_sort=sortrows(tabl,3);
tabl_sort(:,3)=[];
tabl(:,3)=[];
disp(tabl_sort(:,:));

disp("Интерполяционный многочлен в форме Ньютона по значениям x:");
pn=newton(tabl_sort, n)
pn=pn-F;
h=1e-2;
eps=1e-5;
[num_of_roots, intervals]=localization(A(1),A(2),h,pn);
for i=1:num_of_roots
    [roots(i), u(i), count(i)]=secant(intervals(i,1), intervals(i,2),eps,pn);
end
for i=1:num_of_roots
    disp("Корень уравнения f(x)=F");
    disp(roots(i));
    u3=abs(double(subs(f,roots(i)))-F);
    disp("Невязка:");
    disp(u3);
end;
while (1>0)
flag=input("Введите 1, если хотите ввести новые значения x и n и введите 0, если хотите выйти из программы: ");
if (flag~=0)&(flag~=1)
    disp("Введено неверное значение");
end
if (flag==0)|(flag==1)
    break;
end
end
end