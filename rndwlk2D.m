function [tv, X] = rndwlk2D(D,tv,np)

kt = length(tv);
nd = 2;

dt = tv(2) - tv(1);
ds = sqrt(D*dt*nd*2);

Hang = rand((kt-1), 1, np)*2*pi;

dX = ds*[cos(Hang), sin(Hang)];
X = cumsum(dX);
