function [ CorrArr ] = gencorr( l,c,m,v)
%gencorr inputs--> l=Length of the array you want to enerate
%                  c=Correlation of the first lag
%                  m=Mean value of the array
%                  v=Variance of the array (it wont be very exact)
%   Detailed explanation goes here
Mdl = arima('MA',{c},'Constant',m,'Variance',v);
CorrArr = simulate(Mdl,l);
return;
end

