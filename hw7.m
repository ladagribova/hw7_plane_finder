clear all;
data = dlmread('test.txt'); % считывание данных 
x = data(3:end,1);
y = data(3:end,2);
z = data(3:end,3);
maxDistance = data(1:1,1); %отклонение p
cloud = [x y z];
referenceVector = [0,0,1]; %вектор нормали
ptCloud = pointCloud(cloud); %формирование облака точек
plane = pcfitplane(ptCloud,maxDistance,referenceVector); %читерская функция определения плоскости
%вытаскиваем найденные параметры лучшей плоскости
A = plane.Parameters(1,1);  
B = plane.Parameters(1,2);
C = plane.Parameters(1,3);
D = plane.Parameters(1,4);
fileID = fopen('C:\Users\User\Desktop\ans.txt','w+');
fprintf('%f %f %f %f\n', A, B, C, D); %выводим их в консоль
fprintf(fileID,'%f %f %f %f\n', A, B, C, D); %вывод в файл на рабочий стол
fclose(fileID);