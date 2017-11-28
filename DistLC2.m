function [ x,lc,comb ] = DistLC2( y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ymin=floor(min(y));
ymax=ceil(max(y));
length=round((ymax-ymin)*1000);
lc=zeros(1,length);
for i=ymin:0.001:ymax-0.001
    lc(1+int32((i-ymin)*1000))=Cross_N_ND(y,i);
end
x=(ymin:0.001:ymax-.001);
comb=[x; lc];
comb=comb';
end

