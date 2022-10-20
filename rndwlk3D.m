function [tv, X] = rndwlk3D(D,tv,np)

kt = length(tv);
nd = 3;

dt = tv(2) - tv(1);
ds = sqrt(D*dt*nd*2);

Hang = rand((kt-1), 1, np)*2*pi;
Vang = 2*(rand((kt-1), 1,np)*pi./2)- pi/2;

dX = ds*[cos(Hang).*cos(Vang), sin(Hang).*cos(Vang), sin(Vang)];

X = cumsum(dX);

