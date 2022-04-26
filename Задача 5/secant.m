function [root, u, k]=secant(a,b,eps,f)
x1=a;
x2=b;
y1=double(subs(f,x1));
y2=double(subs(f,x2));
k=0;
while abs(y2)>eps
    x3=x2-y2/(y2-y1)*(x2-x1);
    x1=x2;
    x2=x3;
    y1=y2;
    y2=double(subs(f,x2));
    k=k+1;
end
root=x2;
u=abs(y2);
end