clear all;
syms f1(x,y) y(x) yt(x);
syms u(x);
f1=sin(x)-y;
f=@(x,y) sin(x)- y;
u=@(x) 3/2*exp(-x)+1/2*(sin(x)-cos(x));
N=10; h=0.1; x0=0; y0=1;
disp("Решается задача Коши для ОДУ: y'="+func2str(f)+". Начальное условие y("+num2str(x0)+")="+num2str(y0));
disp("Точное решение задачи Коши: y(x)="+func2str(u));
for i=-2:N
%     xk(i+3)=x0+i*h;
%     yk(i+3)=double(subs(u,xk(i+3)));
    disp("x_"+num2str(i)+"="+num2str(x0+i*h)+"  y_"+num2str(i)+"="+num2str(u(x0+i*h)));
end;
fprintf('\n');
%%
yt=y0;
for i=1:8
    yi(i)=double(subs(diff(f1,x,i-1),{x,y},{x0,y0}));
    yt=yt+yi(i)/factorial(i)*(x-x0)^i;
end;
disp("Метод разложение в ряд Тейлора, полученная функция y(x)="+string(yt));
for k=-2:2
    xk(k+3)=x0+k*h;
    ytt=matlabFunction(yt);
    yk(k+3)=ytt(xk(k+3));
    disp("x_"+num2str(k)+"="+num2str(xk(k+3))+"  y_"+num2str(k)+"="+num2str(yk(k+3))+...
    ", Абсолютная погрешность delta="+num2str(abs(u(x0+k*h)-yk(k+3))));
end;
%%
fprintf('\n');
disp("Метод Адамса");
A=[xk', yk']; 
n=length(xk);
for i=1:n
    A(i,3)=h*f(xk(i),yk(i));
end;
AA=A;
for i=3:n+1
    for j=1:(n+2-i)
        A(j,i+1)=(A(j+1,i)-A(j,i));
    end
end
for i=6:(N+3)
    xk(i)=x0+(i-3)*h; A(i,1)=xk(i); AA(i,1)=xk(i);
    yk(i)=yk(i-1)+A(i-1,3)+1/2*A(i-2,4)+5/12*A(i-3,5)+3/8*A(i-4,6)+251/720*A(i-5,7);
    AA(i,2)=yk(i-1)+1/720*(1901*AA(i-1,3)-2774*AA(i-2,3)+2616*AA(i-3,3)-1274*AA(i-4,3)+251*AA(i-5,3));
    AA(i,3)=AA(i,2)*h;
        disp("x_"+num2str(i-3)+"="+num2str(xk(i))+"  y_"+num2str(i-3)+"="+num2str(yk(i))+...
    ", Абсолютная погрешность delta="+num2str(abs(u(xk(i))-yk(i))));
     disp("Безразностная схема: x_"+num2str(i-3)+"="+num2str(AA(i,1))+"  y_"+num2str(i-3)+"="+num2str(AA(i,2))+...
 ", Абсолютная погрешность delta="+num2str(abs(u(xk(i))-AA(i,2))));
    A(i,2)=yk(i);
    A(i,3)=h*f(xk(i),yk(i));
    for j=4:(length(A(1,:))+1)
       % A(i-j+3,j)=(A(i-j+4,j-1)-A(i-j+3,j-1))/(A(i-j+4,1)-A(i-j+3,1));
       A(i-j+3,j)=(A(i-j+4,j-1)-A(i-j+3,j-1));
    end; 
end;

%% Метод Рунге-Кутта
fprintf('\n');
disp("Метод Рунге-Кутта 4-го порядка");
xk1(1)=x0; yk1(1)=y0;
for i=1:(N+1)
    xk1(i+1)=x0+i*h;
    k1=h*f(xk1(i),yk1(i));
    k2=h*f(xk1(i)+h/2,yk1(i)+k1/2);
    k3=h*f(xk1(i)+h/2,yk1(i)+k2/2);
    k4=h*f(xk1(i)+h, yk1(i)+k3);
    yk1(i+1)=yk1(i)+1/6*(k1+2*k2+2*k3+k4);
    disp("x_"+num2str(i-1)+"="+num2str(xk1(i))+"  y_"+num2str(i-1)+"="+num2str(yk1(i))+...
        ", Абсолютная погрешность delta="+num2str(abs(double(subs(u,x0+(i-1)*h))-yk1(i))));
end;

%% Метод Эйлера
fprintf('\n');
disp("Метод Эйлера");
xk2(1)=x0; yk2(1)=y0;
for i=1:(N+1)
    xk2(i+1)=x0+i*h;
    yk2(i+1)=yk2(i)+h*f(xk2(i),yk2(i));
    disp("x_"+num2str(i-1)+"="+num2str(xk2(i))+"  y_"+num2str(i-1)+"="+num2str(yk2(i))+...
        ", Абсолютная погрешность delta="+num2str(abs(double(subs(u,x0+(i-1)*h))-yk2(i))));
end;
%% Улучшенный метод Эйлера
fprintf('\n');
disp("Улучшенный метод Эйлера");
xk3(1)=x0; yk3(1)=y0;
for i=1:(N+1)
    xk3(i+1)=x0+i*h;
    yk3(i+1)=yk3(i)+h*f(xk3(i)+h/2,yk3(i)+h/2*f(xk3(i),yk3(i)));
    disp("x_"+num2str(i-1)+"="+num2str(xk3(i))+"  y_"+num2str(i-1)+"="+num2str(yk3(i))+...
        ", Абсолютная погрешность delta="+num2str(abs(u(x0+(i-1)*h)-yk3(i))));
end;
%% Улучшенный метод Эйлера 2
fprintf('\n');
disp("Улучшенный метод Эйлера II");
xk3(1)=x0; yk3(1)=y0;
for i=1:(N+1)
    xk3(i+1)=x0+i*h;
    yk3(i+1)=yk3(i)+h*f(xk3(i)+h/2,yk3(i)+h/2*f(xk3(i),yk3(i)));
    disp("x_"+num2str(i-1)+"="+num2str(xk3(i))+"  y_"+num2str(i-1)+"="+num2str(yk3(i))+...
        ", Абсолютная погрешность delta="+num2str(abs(u(x0+(i-1)*h)-yk3(i))));
end;