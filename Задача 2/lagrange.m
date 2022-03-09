function pl=lagrange(tabl, f, n)
%syms w(x);
syms lk(x);
syms pl(x);
syms w1(x);
w=1; pl=0;
% for i=1:n+1
%     w=w*(x-tabl(i,1));
%     
% end
for i=1:n+1
    w1=1;
    for j=1:n+1
        if j==i
            continue;
        else
        w1=w1*(x-tabl(j,1));
        end
    end
    lk=w1/double(subs(w1,(tabl(i,1))));
    pl=pl+lk*f(tabl(i,1));
end
pl=collect(vpa(pl));
end