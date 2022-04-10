syms f(x);
syms p0(x) p1(x) p2(x) p3(x);
p0(x)=1; p1(x)=x; p2(x)=x^2; p3(x)=x^3;
f(x)=exp(x)+1/(1+x^2);
disp("Функция f(x)="+string(f));
disp("Первообразная для функции f(x) F(x)="+string(int(f)));
a=input("Введите левый конец промежутка интегрирования: ");
b=input("Введите правый конец промежутка интегрирования: ");
kf(f,a,b);
% kf(p0,a,b);
% kf(p1,a,b);
% kf(p2,a,b);
% kf(p3,a,b);

function kf(f,a,b)
disp("Для функции " + string(f) +" выполняется численное интегрирование по простейшим квадратурным формулам");
J=double(subs(int(f),b)-subs(int(f),a));
disp("Значение интеграла: "+num2str(J));
fprintf('\n');
J1=double(subs(f,a))*(b-a);
disp("Значение по формуле левого прямоугольника: "+num2str(J1));
disp("Абсолютная погрешность для формулы левого прямоугольника: "+num2str(abs(J1-J)));
fprintf('\n');
J2=double(subs(f,b))*(b-a);
disp("Значение по формуле правого прямоугольника: "+num2str(J2));
disp("Абсолютная погрешность для формулы правого прямоугольника: "+num2str(abs(J2-J)));
fprintf('\n');
J3=double(subs(f,(a+b)/2))*(b-a);
disp("Значение по формуле среднего прямоугольника: "+num2str(J3));
disp("Абсолютная погрешность для формулы среднего прямоугольника: "+num2str(abs(J3-J)));
fprintf('\n');
J4=double((subs(f,a)+subs(f,b)))*(b-a)/2;
disp("Значение по формуле трапеции: "+num2str(J4));
disp("Абсолютная погрешность для формулы трапеции: "+num2str(abs(J4-J)));
fprintf('\n');
J5=double((subs(f,a)+4*subs(f,(a+b)/2)+subs(f,b)))*(b-a)/6;
disp("Значение по формуле Симпсона: "+num2str(J5));
disp("Абсолютная погрешность для формулы Симпсона: "+num2str(abs(J5-J)));
fprintf('\n');
J6=double(1/8*subs(f,a)+3/8*subs(f,a + (b-a)/3)+3/8*subs(f,a + 2*(b-a)/3)+1/8*subs(f,b))*(b-a);
disp("Значение по формуле 3/8: "+num2str(J6));
disp("Абсолютная погрешность для формулы 3/8: "+num2str(abs(J6-J)));
end
