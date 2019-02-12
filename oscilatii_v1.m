%2 componente param. egali(k,m).
clear all;
close all;
clc;
m = 1e-2;
k = 100;
csi10 = 1e-2;
csi20 = 3*1e-2;
v10 = 0;
v20 = 0;
t0 = 0;
tf = 0.1;
N = 1500;
t = linspace(t0,tf,N);
dt = t(7) - t(6);
csi1 = zeros(1,N);
csi2 = zeros(1,N);
csi1(1) = csi10;
csi2(1) = csi20;
csi1(2) = csi10 + dt*v10;
csi2(2) = csi20 + dt*v20;
for i = 2:N-1
    csi1(i+1) = 2*csi1(i) - csi1(i-1)-dt^2*k/m*(2*csi1(i) - csi2(i));
    csi2(i+1) = 2*csi2(i) - csi2(i-1)-dt^2*k/m*(2*csi2(i) - csi1(i));
end
figure(1);
plot(t,csi1,'-r');
hold on;
plot(t,csi2,'-b');
grid;
xlabel('t(s)');
ylabel('csi(m)');
legend('corp1','corp2');