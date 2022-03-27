function pn=newton(tabl, n)
syms pn(x);
syms w(x);
pn=0;
%tabl=[-1,9; 1,3; 2,3;3,5];
%n=3;
for i=2:n+1
    for j=1:(n+2-i)
        tabl(j,i+1)=(tabl(j+1,i)-tabl(j,i))/(tabl(j+i-1,1)-tabl(j,1));
    end
end
for i=0:n
    w=1;
    for j=1:i
        w=w*(x-tabl(j,1));
    end
    pn=pn+tabl(1,i+2)*w;
end
pn=collect(vpa(pn));
end
