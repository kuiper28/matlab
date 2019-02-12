
% Versiunea V_4 a programului in care am introdus
% la capatul din stanga o conditie la frontiera si am marit numarul de 
% componente.

clear all; close all; clc;

m = 1e-2; k = 100;
n = 20; %nr de componente
w = 100;% pulsatia
csi0 = sin((1:n)/n*pi);
v0 = zeros(1,n);
t0 = 0; tf = 0.1; N = 1500;
t = linspace(t0, tf, N); dt = t(7) - t(6);

% conditia la frontiera la capatul din stanga
csi_s = zeros(1,N);
for k = 2:N
   if t(k) < (2*pi)/w;
    csi_s(k) =  sin(t(k)*w)*sin(t(k)*w);
   end
end
csi = zeros(n,N);
csi(:,1) = csi0;
csi(:,2) = csi0 + dt*v0;

for i = 2:N-1
    csi(1, i+1) = 2* csi(1, i) - csi(1,i-1) - dt^2 * k/m * (2 * csi(1,i) - csi(2,i)) -csi_s(i);
end
for j = 2:n-1
    for i = 2:N-1
        csi(j,i+1) = 2* csi(j,i) - csi(j,i-1) - dt^2 * k/m * (2*csi(j,i) - csi(j-1,i) - csi(j+1,i));
    end;
end
for i = 2:N-1
    csi(n, i+1) = 2* csi(n,i) - csi(n, i-1) - dt^2 * k/m * (2*csi(n,i) - csi(n-1,i));
end
    
l0 = 5; x = (1:n) * l0;
figure(1);
[xx,tt] = meshgrid(x,t);
surfl(xx,tt,csi');
shading interp;
xlabel('lungime');
ylabel('timp');
zlabel('amplitudine');

figure (2);
plot(x, csi(:,1), '-r');
for i=1:N
    plot(x, csi(:,i), '-r')
    Film(:,i) = getframe;
end;
