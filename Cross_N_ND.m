%% this function takes two variable:- 
%    x: vector of real values
%    L: Level of crossing
% this function returns two variables:-
%    CN_ND: crossing number in negative direction
%    CNV  : vector denoting the location of xrossing at negative direction

function  [CN_ND, CNV]= Cross_N_ND(x,L)
b=double((x<L));
c=b;
for k=1:length(b)-1
      
    if b(k)==1 && b(k+1)==1
       c(k+1)=0;
    end
end

%temp begin\------------------------------

bb=double((x>L));
cc=bb;
for k=1:length(bb)-1
      
    if bb(k)==1 && bb(k+1)==1
       cc(k+1)=0;
    end
end


%temp End\--------------------------------
c_sum=(sum(c)+sum(cc));


CN_ND=c_sum;
CNV=c;