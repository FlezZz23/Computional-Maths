tic
clear all;
syms f(x)
f(x)=x*sin(x)-1;
A=-10; B=2;
h=1e-1;
eps=1e-5;
[num_of_roots, intervals]=localization(A,B,h,f);
method=3; %1 - бисекция, 2 - Ньютон, 3 - Ньютон+, 4 - секущие;
if method==1
    for i=1:num_of_roots
        [roots(i),delta(i), u(i), count(i)]=bisection(intervals(i,1), intervals(i,2),eps,f);
    end;
    time=toc;
for i=1:num_of_roots
            str1(i)="x"+num2str(i)+"="+num2str(roots(i))+", невязка u="+ num2str(u(i))+", число шагов k="+ num2str(count(i))+", delta="+ num2str(delta(i));
    end;
    str=["Функция f(x)="+ string(f);...
    "Поиск корней на промежутке [" + num2str(A)+"," + num2str(B) + "]";...
    "Время работы программы: " + num2str(time) + " с";...
    "Метод бисекции, число корней = " + num2str(num_of_roots);...
    "Точность решения eps = " + num2str(eps); str1'];
    mh=msgbox(str, 'Program', 'help');
    th = findall(mh, 'Type', 'Text'); %get handle to text within msgbox
    th.FontSize = 16; %Change the font size
    deltaWidth = sum(th.Extent([1,3]))-mh.Position(3) + th.Extent(1);
    deltaHeight = sum(th.Extent([2,4]))-mh.Position(4) + 10;
    mh.Position([3,4]) = mh.Position([3,4]) + [deltaWidth, deltaHeight];
    mh.Resize = 'on';
elseif method==2
    for i=1:num_of_roots
        [roots(i), u(i), count(i), x0(i)]=newton(intervals(i,1), intervals(i,2),eps,f);
    end;
    time=toc;
    for i=1:num_of_roots
            str1(i)="x"+num2str(i)+"="+num2str(roots(i))+", невязка u="+ num2str(u(i))+", число шагов k="+ num2str(count(i))+", х0="+ num2str(x0(i));
    end;
    str=["Функция f(x)="+ string(f);...
    "Поиск корней на промежутке [" + num2str(A)+"," + num2str(B) + "]";...
    "Время работы программы: " + num2str(time) + " с";...
    "Метод Ньютона, число корней = " + num2str(num_of_roots);...
    "Точность решения eps = " + num2str(eps); str1'];
    mh=msgbox(str, 'Program', 'help');
    th = findall(mh, 'Type', 'Text'); %get handle to text within msgbox
    th.FontSize = 16; %Change the font size
    deltaWidth = sum(th.Extent([1,3]))-mh.Position(3) + th.Extent(1);
    deltaHeight = sum(th.Extent([2,4]))-mh.Position(4) + 10;
    mh.Position([3,4]) = mh.Position([3,4]) + [deltaWidth, deltaHeight];
    mh.Resize = 'on';
elseif method==3
        for i=1:num_of_roots
        [roots(i), u(i), count(i), x0(i)]=newton(intervals(i,1), intervals(i,2),eps,f);
    end;
    time=toc;
    for i=1:num_of_roots
            str1(i)="x"+num2str(i)+"="+num2str(roots(i))+", невязка u="+ num2str(u(i))+", число шагов k="+ num2str(count(i))+", х0="+ num2str(x0(i));
    end;
    str=["Функция f(x)="+ string(f);...
    "Поиск корней на промежутке [" + num2str(A)+"," + num2str(B) + "]";...
    "Время работы программы: " + num2str(time) + " с";...
    "Метод Ньютона, модифицированный, число корней = " + num2str(num_of_roots);...
    "Точность решения eps = " + num2str(eps); str1'];
    mh=msgbox(str, 'Program', 'help');
    th = findall(mh, 'Type', 'Text'); %get handle to text within msgbox
    th.FontSize = 16; %Change the font size
    deltaWidth = sum(th.Extent([1,3]))-mh.Position(3) + th.Extent(1);
    deltaHeight = sum(th.Extent([2,4]))-mh.Position(4) + 10;
    mh.Position([3,4]) = mh.Position([3,4]) + [deltaWidth, deltaHeight];
    mh.Resize = 'on';
elseif method==4
    for i=1:num_of_roots
        [roots(i), u(i), count(i)]=secant(intervals(i,1), intervals(i,2),eps,f);
    end;
    time=toc;
for i=1:num_of_roots
            str1(i)="x"+num2str(i)+"="+num2str(roots(i))+", невязка u="+ num2str(u(i))+", число шагов k="+ num2str(count(i));
    end;
    str=["Функция f(x)="+ string(f);...
    "Поиск корней на промежутке [" + num2str(A)+"," + num2str(B) + "]";...
    "Время работы программы: " + num2str(time) + " с";...
    "Метод секущих, число корней = " + num2str(num_of_roots);...
    "Точность решения eps = " + num2str(eps); str1'];
    mh=msgbox(str, 'Program', 'help');
    th = findall(mh, 'Type', 'Text'); %get handle to text within msgbox
    th.FontSize = 16; %Change the font size
    deltaWidth = sum(th.Extent([1,3]))-mh.Position(3) + th.Extent(1);
    deltaHeight = sum(th.Extent([2,4]))-mh.Position(4) + 10;
    mh.Position([3,4]) = mh.Position([3,4]) + [deltaWidth, deltaHeight];
    mh.Resize = 'on';
end