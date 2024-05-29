%4.
clear 
close all
load sunspot.txt
figure
plot(sunspot(:,1),sunspot(:,2), 'r-*')
xlabel('Rok')
ylabel('Ilość plam')
title('Wykres ilości plam słonecznych')

%5
L=length(sunspot);
P=[sunspot(1:L-2,2)'
    sunspot(2:L-1,2)'];
T=sunspot(3:L,2)';

%6
figure(2)
plot3(P(1,:),P(2,:),T,'bo')
grid on
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Wizualizacja danych trójwymiarowych');
hold on;

%7
Pu=P(:,1:200);
Tu=T(:,1:200);

%8
net = newlind(Pu, Tu);

%9
disp('Współczynniki wagowe neuronu')
disp(net.IW{1})
disp(net.b{1})

w1=net.IW{1}(1);
w2=net.IW{1}(2);
b=net.b{1};

%15
[X, Y] = meshgrid(0:1:200, 0:1:200);
Z = w1 * X + w2 * Y + b;
mesh(X, Y, Z);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Aproksymująca płaszczyzna neuronu liniowego');

%10
Tsu=sim(net,Pu);

figure(3)
plot(sunspot(1:200,1), Tu, 'r')
hold on
plot(sunspot(1:200,1), Tsu, 'b')
xlabel('Rok')
ylabel('Ilość plam')
title('Porównanie danych')
legend('Dane rzeczywiste', 'Dane obliczone')

%11
net2 = newlind(P,T);
Tsu2= sim(net2,P);

figure(4)
plot(sunspot(1:249,1), T, 'r-*')
hold on
plot(sunspot(1:249,1), Tsu2, 'b-*')
xlabel('Rok')
ylabel('Ilość plam')
title('Porównanie danych 2')
legend('Dane rzeczywiste', 'Dane obliczone')

%12
e = Tu - Tsu;
figure(5)
plot(sunspot(1:200,1), e, 'r-*')
xlabel('Rok')
ylabel('Wartości wektora błędu')
title('Wektor błędu')

%13
figure(6)
histogram(e)
xlabel('Watrtości')
ylabel('Występowanie')
title('Histogram wektora błędu')

srednia = mean(e);
max = max(e);
odchylenie_standardowe = std(e);

%14
mse = mse(Tu, Tsu);
sse = sse(Tu, Tsu);

%16
P6 = [];
T6 = [];

for i = 1:(L-6)
    P6 = [P6; sunspot(i:i+5, 2)'];
    T6 = [T6 sunspot(i+6, 2)];
end
P6 = P6';


net6 = newlind(P6,T6);
Tsu6 = sim(net6,P6);

figure(7)
plot(sunspot(1:245,1),T6,'r-*')
hold on
plot(sunspot(1:245,1),Tsu6,'b-*')
xlabel('Rok')
ylabel('Ilość plam')
title('Porównanie danych 3')
legend('Dane rzeczywiste','Dane obliczone z 6 lat poprzednich')

e6 = T6 - Tsu6;
figure(8)
plot(sunspot(1:200,1),e,'r-*')
xlabel('Rok')
ylabel('Wartości wektora błędu')
title('Wektor błędu 6 lat')

P12 = [];
T12 = [];

for i = 1:(L-12)
    P12 = [P12; sunspot(i:i+11, 2)'];
    T12 = [T12 sunspot(i+12, 2)];
end
P12 = P12';

net12 = newlind(P12,T12);
Tsu12 = sim(net12,P12);

figure(9)
plot(sunspot(1:239,1),T12,'r-*')
hold on
plot(sunspot(1:239,1),Tsu12,'b-*')
xlabel('Rok')
ylabel('Ilość plam')
title('Porównanie danych 4')
legend('Dane rzeczywiste','Dane obliczone z 12 lat poprzednich')

e12 = T12 - Tsu12;
figure(10)
plot(sunspot(1:200,1),e,'r-*')
xlabel('Rok')
ylabel('Wartości wektora błędu')
title('Wektor błędu 12 lat')





