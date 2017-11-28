function [ flhm,hlem ] = findwidth( x,y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

halfmax=(max(y)/2);
inversE2max=(max(y)/(exp(1)^2));

y1=find(y>halfmax,1,'first');
y2=find(y>halfmax,1,'last');
y11=find(y>inversE2max,1,'first');
y22=find(y>inversE2max,1,'last');
flhm=x(y2)-x(y1);
hlem=(x(y22)-x(y11))/2;



end

