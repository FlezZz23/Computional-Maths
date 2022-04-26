%% Нахождение корней полинома Лежандра и вычисление коэффициентов КФ Гаусса
for N=[1 2 3 4 5 6 7 8 9]
syms pn(x) g(x) f(x);
h=1e-2;
eps=1e-12;
pn=1/(2^N*factorial(N))*diff((x^2-1)^N,N);
g=diff(pn);
f=x^(2*N-1)+3*x+5;
[num_of_roots,intervals]=localization(-1,1,h,pn);
for i=1:num_of_roots 
    [roots(i), u(i), count(i)]=secant(intervals(i,1), intervals(i,2),eps,pn);
end;
Ak=2./(1-roots.^2)./(double(subs(g,roots))).^2;
disp("N= "+num2str(N));
for i=1:num_of_roots
    disp("A_k="+num2str(Ak(i))+" x_k="+num2str(roots(i)));
end;
disp("Для многочлена f(x)= "+string(f));
disp("Точное значение интеграла: "+num2str(double((subs(int(f),1))-subs(int(f),-1))));
kf=0;
for i=1:num_of_roots
    kf=kf+double(subs(f,roots(i)))*Ak(i);
end;
disp("Значение интеграла, вычисленно по КФ Гаусса: "+num2str(kf));
fprintf('\n');
end;
%% Вычисление интеграла при помощи КФ Гаусса
a=input("Введите значение левой границы ");
b=input("Введите значение правой границы ");
for N=5
syms pn(x) g(x) f(x);
h=1e-2;
eps=1e-12;
pn=1/(2^N*factorial(N))*diff((x^2-1)^N,N);
g=diff(pn);
f=log(1+x)/(1+x^2);
fun=@(x) log(1+x)./(1+x.^2);
[num_of_roots,intervals]=localization(-1,1,h,pn);
for i=1:num_of_roots 
    [roots(i), u(i), count(i)]=secant(intervals(i,1), intervals(i,2),eps,pn);
end;
Ak=2./(1-roots.^2)./(double(subs(g,roots))).^2;
Bk=(b-a)/2.*Ak;
xk=(b-a)/2.*roots + (b+a)/2;
disp("N= "+num2str(N));
for i=1:num_of_roots
    disp("A_k="+num2str(Bk(i))+" x_k="+num2str(xk(i)));
end;
disp("Для функции f(x)= "+string(f));
disp("Точное значение интеграла: "+num2str(integral(fun,a,b)));
kf=0;
for i=1:num_of_roots
    kf=kf+double(subs(f,xk(i)))*Bk(i);
end;
disp("Значение интеграла, вычисленно по КФ Гаусса: "+num2str(kf));
disp("Абсолютная погрешность: "+num2str(abs(kf-integral(fun,a,b))));
fprintf('\n');
end;
%% Вычисление интеграла при помощи КФ Мелера
N1=input("Введите значение N1 ");
N2=input("Введите значение N2 ");
N3=input("Введите значение N3 ");
syms p(x);
p=1/sqrt(1-x^2);
f=1/sqrt(1+x^2);
fun=@(x) 1./sqrt(1-x.^2).*1./sqrt(1+x.^2);
disp("Для функции f(x)*p(x)= "+string(f*p));
disp("Точное значение интеграла: "+num2str(integral(fun,-1,1)));
fprintf('\n');
for N=[N1 N2 N3]
    disp("N="+num2str(N));
    for i=1:N
        xk(i)=cos((2*i-1)/(2*N)*pi);
    end;
    Ak=pi/N;
    kf=0;
    for i=1:N
        disp("A_k="+num2str(Ak)+" x_k="+num2str(xk(i)));
        kf=kf+double(subs(f,xk(i)))*Ak;
    end;
    disp("Значение интеграла, вычисленно по КФ Гаусса: "+num2str(kf));
    disp("Абсолютная погрешность: "+num2str(abs(kf-integral(fun,-1,1))));
    fprintf('\n');
end;

