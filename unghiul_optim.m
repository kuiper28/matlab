

function[ theta_opt, dif_opt ] = unghiul_optim(vs,d)
%am creat o functie care imi calculeaza unghiul optim minim
%pentru o anumita valoare a vitezei (vs) si o anumita distanta
%la care se afla tinta (d)
th = 0:0.1:45;
x_opt = 0;
y_opt = 0;
m = 0.5;%masa proiectilului
g = 9.806;
vlim = 100;
r1 = m*g/vlim;
r2 = r1/vs;
m = 0.5;
N = 2000;
u = zeros(1,N);%viteza pe axa OX
v = u;%Viteza pe axa OY
t0 = 0;
theta_opt = 1;%unghiul optim cautat setat initial la 1
x = zeros(1,N);
y = zeros(1,N);

dif_opt = 100;%toleranta
for theta = th
    u(1) = vs*cos(theta);
    v(1) = vs*sin(theta);
    tf = 2*vs*sin(theta)/g;
    time = linspace(t0,tf,N);
    dt = time(2) - time(1);
    for t = 1:N-1;
        vit = sqrt(u(t)^2 + v(t)^2);
        ax = (-r1*u(t) - r2*vit*u(t))/m;
        ay = (-r1*v(t) - r2*vit*v(t))/m - g;
        u(t+1) = u(t) +ax*dt;
        v(t+1) = v(t) +ay*dt;
        x(t+1) = x(t) + u(t) * dt;
        y(t+1) = y(t) + v(t) * dt;
        if y(t+1) < 0
            dif = min(abs(x(t+1) - d));
            if(dif < dif_opt)%cazul in care diferenta este mai mica
            %decat toleranta
                theta_opt = theta;
                dif_opt = dif;
                x_opt = x;
                y_opt = y;
            end
            break
        end
        if y(t+1) < 0;
            break
        end
    end
time = time(1:t);
u = u(1:t);
v = v(1:t);
x = x(1:t);
y = y(1:t);
end
plot(x_opt,y_opt);
   disp(theta_opt);
   disp(dif_opt);%afisam diferenta optima(toleranta).
   %In cazul in care dif nu va fi mai mic decat dif_opt,
   %setat initial la 100, atunci se va  afisa 100,iar unghiul optim 
   %1.
   %Observatie: Exita sansa ca la rulare sa dureze cateva momente pana
   %cand vor fi afisate rezultatele. 
