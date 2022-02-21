function [root, u, k, x0]=newton_modify(a,b,eps,f)
f1=diff(f);
f2=diff(f1);
if (double(vpa(f1(a)))*double(vpa(f1(b)))<0)&&(double(vpa(f2(a)))*double(vpa(f2(b)))<0)
    root=NaN;
    u=NaN;
    k=NaN;
    x0=NaN;
else
    x0=a+rand()*(b-a);
    while (double(vpa(f(x0)))*double(vpa(f2(x0)))<=0)
       x0=a+rand()*(b-a);
    end
x1=x0-double(vpa(f(x0)))/double(vpa(f1(x0)));
y1=double(vpa(f(x1)));
y11=double(vpa(f1(x0)));
k=0;
    while abs(y1)>eps
    x2=x1-y1/y11;
    x1=x2;
    y1=double(vpa(f(x2)));
    k=k+1;
    end
end
root=x1;
u=abs(y1);
end