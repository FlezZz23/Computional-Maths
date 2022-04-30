%%
syms pn(x) g(x) f(x) po(x);
a=input("Введите значение левой границы ");
b=input("Введите значение правой границы ");
m=input("Введите число разбиений отрезка интегрирования ");
N=input("Введите число узлов ");
h=(b-a)/m;
h1=1e-2;
eps=1e-12;
pn=1/(2^N*factorial(N))*diff((x^2-1)^N,N);
g=diff(pn);
%f=log(1+x)/(1+x^2);
%fun=@(x) log(1+x)./(1+x.^2);
f=sin(x);
fun=@(x) sin(x);
[num_of_roots,intervals]=localization(-1,1,h1,pn);
for i=1:num_of_roots 
    [roots(i), u(i), count(i)]=secant(intervals(i,1), intervals(i,2),eps,pn);
end;
Ak=2./(1-roots.^2)./(double(subs(g,roots))).^2;

for i=0:m-1
Bk=h/2.*Ak;
xk=h/2.*roots + (a+i*h+a+(i+1)*h)/2;
disp("N= "+num2str(N));
for j=1:num_of_roots
    disp("A_k="+num2str(Bk(j))+" x_k="+num2str(xk(j)));
end;
kf(i+1)=0;
for k=1:num_of_roots
    kf(i+1)=kf(i+1)+double(subs(f,xk(k)))*Bk(k);
end;
end;
disp("Для функции f(x)= "+string(f));
disp("Точное значение интеграла: "+num2str(integral(fun,a,b),12));
kf_res=sum(kf);
disp("Значение интеграла, вычисленно по КФ Гаусса: "+num2str(kf_res,12));
disp("Абсолютная погрешность: "+num2str(abs(kf_res-integral(fun,a,b))));
fprintf('\n');

%%
syms w(x,p,k) p1(x) lkn(x);
f=sin(x);
fun=@(x) sin(x);
a=0;
b=1;
po=log(x+1);
po_fun=matlabFunction(po);
N=5;
disp("N="+num2str(N));
m=1;
p1=x^(2*N-1);
for i=0:(2*N-1)
    mu(i+1)=integral(matlabFunction(po*x^i), a, b);
    disp(num2str(i)+" момент веса равен: "+num2str(mu(i+1)));
end;
fprintf('\n');

for i=1:N
    for j=1:N
        A(i,j)=mu(i+j-1);
    end;
    B(i)=-mu(i+N);
end;
P=A\B';
w=0;
for i=1:N
    w=w+P(i)*x^(i-1);
end;
w=w+x^N;
xk=double(vpasolve(w==0,x));
disp("Узлы и коэффициенты КФНАСТ")
for i=1:N
    lkn=w/(x-xk(i))/subs(diff(w),xk(i));
    Ck(i)=integral(matlabFunction(po*lkn*lkn),a,b);
    disp("A_k="+num2str(Ck(i))+" x_k="+num2str(xk(i)));
end;
disp("Ортогональный многочлен "+string(w));
disp("Проверка формулы для многочлена: "+string(p1*po));
disp("Точное значение интеграла: "+num2str(integral(matlabFunction(p1*po),a,b)));
kf_test=0;
kf1=0;
for i=1:N
    kf_test=kf_test+Ck(i)*double(subs(p1,xk(i)));
    kf1=kf1+Ck(i)*double(subs(f,xk(i)));
end;
disp("Значение интеграла вычисленное по КФНАСТ: "+num2str(kf_test));
fprintf('\n');
disp("Проверка формулы для функции: "+string(f*po));
disp("Точное значение интеграла: "+num2str(integral(matlabFunction(f*po),a,b)));
disp("Значение интеграла вычисленное по КФНАСТ: "+num2str(kf1));