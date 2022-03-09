%%
syms f(x);
syms pl(x);
syms pn(x);
disp("Решается задача алгебраического интерполирования. Вариант 5, функция для интерполяции: ");
f(x)=1-exp(-2*x)
m1=input("Введите число значений в таблице m+1: ");
m=m1-1;
A=input("Введите концы отрезка [a, b], из которого выбираются узлы интерполяции: ");
disp("Построенная таблица значений: ");
tabl=A(1)+(A(2)-A(1))*rand(m+1,1)
%%
flag=1;
while flag==1
x0=input("Введите x‒точку интерполирования, значение в которой хотим найти: ");
for i=1:m+1 
    tabl(i,2)=double(vpa(f(tabl(i,1))));
    tabl(i,3)=abs(tabl(i,1)-x0);
end
disp("Отсортированная таблица значений: ");
tabl_sort=sortrows(tabl,3);
tabl_sort(:,3)=[];
disp(tabl_sort(:,1));
while (1>0)
    n=input("Введите n‒степень интерполяционного многочлена, который будет построен для того, чтобы найти значение в точке x: ");
    if (n>m)
        disp("Введено недопустимое значение n");
    else
        break;
    end
end

disp("Интерполяционный многочлен в форме Лагранжа:");
pl=lagrange(tabl_sort, f, n)
disp("Значение в точке x: "+ num2str(double(subs(pl,x0))));
u1=abs(double(subs(f,x0)) - double(subs(pl,x0)));
disp("Абсолютная погрешность в точке x: "+ num2str(u1));

disp("Интерполяционный многочлен в форме Ньютона:");
pn=newton(tabl_sort, n)
disp("Значение в точке x: "+ num2str(double(subs(pn,x0))));
u2=abs(double(subs(f,x0)) - double(subs(pn,x0)));
disp("Абсолютная погрешность в точке x: "+ num2str(u2));

% figure;
% grid on
% hold on
% plot(tabl(:,1), tabl(:,2), 'm*');
% plot(A(1):0.01:A(2), double(subs(f,A(1):0.01:A(2))), 'k');
% plot(A(1):0.01:A(2), double(subs(pl,A(1):0.01:A(2))), 'r');
% plot(A(1):0.01:A(2), double(subs(pn,A(1):0.01:A(2))), 'b');

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