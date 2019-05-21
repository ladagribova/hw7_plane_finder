clear all;
fileID = fopen('C:\Users\User\Desktop\test\test.txt','w+'); %Здесь меняем название файла, если нужно
%генерим количество точек; можно закоментить
a=3;
b=25000;
N = (b-a).*rand + a;
%N=10;
%Генерим количество принадлежащих плоскости точек 
pros=N/2+round((N/2-N/2*0.2).*rand)
%Остаток точек на шум
noise=N-pros
%Генерим отклонение
a=0.01;
b=0.5;
p = (b-a).*rand + a ;
fprintf(fileID,'%f\n%d\n', p, N);
%Генерим точки плоскости дороги
for i=1:3
a=-100;
b=100;
x(i)=(b-a).*rand + a;
y(i)=(b-a).*rand + a;
a=(3).*rand;
b=a+1;
z(i)=(b-a).*rand + a;
fprintf(fileID,'%.2f\t %.2f\t %.2f\t\n', x(i),y(i),z(i));
end
x=x';
y=y';
z=z';
pCloud = pointCloud([x y z]);
model = pcfitplane(pCloud,p);
A = model.Parameters(1,1);
B = model.Parameters(1,2);
C = model.Parameters(1,3);
D = model.Parameters(1,4);
%генерим точки плоскости дороги
for i=4:pros
  a=-100;
  b=100;
  x1=(b-a).*rand + a;
  y1=(b-a).*rand + a;  
  a=0.01;
  b=p;
  z1=-(A*x1+B*y1+D)/C+((b-a).*rand + a)*(-1).^round(2.*rand); 
  fprintf(fileID,'%.2f\t %.2f\t %.2f\t\n', x1,y1,z1);
end
%генерим отклонения
for i=1:noise
  a=-100;
  b=100;
  x1=(b-a).*rand + a;
  y1=(b-a).*rand + a;  
  z1=-(A*x1+B*y1+D)/C+((b-a).*rand + a)*(-1).^round(2.*rand); 
  fprintf(fileID,'%.2f\t %.2f\t %.2f\t\n', x1,y1,z1);
end
fclose(fileID);