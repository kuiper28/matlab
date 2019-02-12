
clear;
clc;
lambda1 = 237;
r01 = 2700;
c1 = 900;
lambda2 = 43;
r02 = 7800;
c2 = 490;
dt = 0.1 % pasul de timp
Lx=0.1;% pas pe axa Ox
Ly=0.1;% pas pe axa Oy
nx=40;
ny=40;
dx = 0.01;
dy= 0.01 
t0 = 0;
tf = 120;
N=1201;
t_f = linspace(t0,tf,N);
T01= 100;
T02 = 77;
D1 = lambda1/r01/c1;
D2 = lambda2/r02/c2;
D = (D1+D2)/2; 

% Conditiile Initiale

for i=1:nx/4
    for j=1:ny/4
        T(i,j,1)=T01;
    end
end
for i= ((nx/4) + 1):nx
    for j = 1:ny
        T(i,j,1)=T02;
    end
end
for i= 1:nx/4
    for j = (ny/4+1):ny
        T(i,j,1) = T02;
    end
end
% Conditiile la frontiera

for i=1:(nx/4)
    T(i,1,1)=T01;
    T(i,ny,1)=T01;
end

for i=(nx/4 + 1):nx
    T(i,1,1)=T02;
    T(i,ny,1)=T02;
end

for j=1:(ny/4)
    T(1,j,1)=T01;
    T(nx,j,1)=T01;
end
for j=(ny/4 + 1):ny
    T(1,j,1)=T02;
    T(nx,j,1)=T02;
end

for t=1:1000
    
    for it=1:N-1
        for i=2:(nx-1)
            for j=2:(ny-1)
                T(i,j,t+1)=D*dt*((T(i+1,j,t)-2*T(i,j,t)+T(i-1,j,t))/(dx^2)+(T(i,j+1,t)-2*T(i,j,t)+T(i,j-1,t))/(dy^2))+T(i,j,t);
            end
        end
    end
    
    % Reprezentare grafica
    % Am folosit temperaturi initiale mai mici pentru a vedea mai bine
    % modul in care se realizeaza schimbul de caldura.
    
    x=linspace(0,Lx,nx);
    y=linspace(0,Ly,ny);
    surf(y,x,T(:,:,t))   
    eval(['print -djpeg heat2d_' num2str(t) '.jpeg']);
end
