function [root, delta, u, k]=bisection(a,b,eps,f)
k=0;
while (b-a)>2*eps
    c=(a+b)/2;
    k=k+1;
    if double(vpa(f(c)))*double(vpa(f(a)))<=0
        b=c;
    else
        a=c;
    end
end
root=(a+b)/2;
delta=(b-a)/2;
u=abs(double(vpa(f(root))));
end