function [counter,ans]=localization(A,B,h,f)
counter=0;
x1=A;
x2=x1+h;
y1=double(subs(f,x1));
while x2<=B
    y2=double(subs(f,x2));
    if y1*y2<=0
        counter=counter+1;
        ans(counter,1)=x1;
        ans(counter,2)=x2;
        ans(counter,3)=y1;
        ans(counter,4)=y2;
    end
    x1=x2;
    x2=x1+h;
    y1=y2;
end
end