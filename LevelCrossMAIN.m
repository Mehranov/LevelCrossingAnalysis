% In this code the following steps will be done in order to create a sequence of random numbers with a desired correlation and evaluate the LevelCrossing
% Method to quantitatively measure the roughness of a surface (in our case the surface is gonna be the electropolished aluminum)
% 1- by entering the l(Length of array), c(the correlation of the first lag), m(the mean value of the array) and v(the variance of the array) we generate the simulated surface
% 2- we then determine the LevelCrossing result of the data created in first step
% 3- we draw the results in step 2
% 4- we shuffle the data created in step 1 to show that the difference between roughness of a correlated sequence, uncorrelated sequence AND a white noise sequence (shuffled)
% The point is showing the potential of this method to evaluate the roughness of the surface (quantitatively). We already now that a correlated surface is smoother than a random surface which is also smoother than an uncorrelated surface


clear all
%close all


% Here we simulate the syrface roughness by creating either Correlcated or
% AntiCorrelated randome numbers. In Case we want to measure the surface
% roughness of real sample we can chenge this section to comment
%% Simulating the surface roughness

% l=input('Enter the Length of the array (surface sample) you want to simulate, a typical number is 100000? ');
% c=input('Enter the correlation value you want to generate, +0.99 is highly correlated and -0.99 is highly uncorrelated');
% m=input('The mean value of your array (recommended is 0 in order to ease the next steps calculation without lossing generality)');
% v=input('The variance of your array, The higher the variance the larger the roughness teeth, the smaller the variance the shorter the roughness teeth');
% y1=gencorr(l,c,m,v);


%% Real surface roughness data
% This part is temporarely comments, In Case of examining real sample this
% section should become uncomment and the above section should become
% comment

[FileName,PathName] = uigetfile({'*.txt';'*.*'},'Select the AFM result');
Path=strcat(PathName,FileName);
y1=importdata(Path);
y1_min=min(y1);y1_max=max(y1);y1_lim=y1_max-y1_min;
y1=2*(y1-y1_min)/y1_lim-1;
%%
y2=shuffle(y1);
size_data=size(y1);
size_data2=size(y2);

[x1,lc1]=DistLC2(y1);
[x2,lc2]=DistLC2(y2);

[Width_half_Max_x1_lc1,Width_e2_Max_x1_lc1]=findwidth(x1,lc1);
[Width_half_Max_x2_lc2,Width_e2_Max_x2_lc2]=findwidth(x2,lc2);
max_lc1=max(lc1);
max_lc2=max(lc2);
Rgh_max_to_max=max_lc2/max_lc1;
GF_lc1=fit(x1',(lc1-min(lc1))','gauss1'); %gaussian fit of the level crossing result
GF_lc2=fit(x2',(lc2-min(lc2))','gauss1');
Rgh_NTotlShfld_dived_NTotl=GF_lc2.a1*GF_lc2.c1*sqrt(pi)/(GF_lc1.a1*GF_lc1.c1*sqrt(pi)); %total number of shuffles LC divided by total number of the original data LV as measure of roughness(i. e. area under the gaussian fit)
Rgh_NTotl_dived_size=GF_lc1.a1*GF_lc1.c1*sqrt(pi)/length(y1);
Rgh_NTotl=GF_lc1.a1*GF_lc1.c1*sqrt(pi);
Roughness_shuffle=GF_lc2.a1*GF_lc2.c1*sqrt(pi)/length(y1);
newFileName=strrep(FileName,'.txt','');
res=strcat('C:\Users\Lab Magnétisme\Dropbox\PhD\MatlabProjects\LevelCrossing\PrepareDataForLCfromGyeddion\Results\',newFileName,'.mat');
res2=strcat('C:\Users\Lab Magnétisme\Dropbox\PhD\MatlabProjects\LevelCrossing\PrepareDataForLCfromGyeddion\Results\',newFileName,'.fig');
%clearvars -except res2 res max_lc1 max_lc2 Rough_value_lc1 Rough_value_lc2 x1 x2 lc1 lc2 Width_half_Max_x1_lc1 Width_e2_Max_x1_lc1 Width_half_Max_x2_lc2 Width_e2_Max_x2_lc2
plot(x1(1:15:length(x1)),lc1(1:15:length(lc1))-min(lc1),'o','color',[.35 .35 .75],'LineWidth',3,'MarkerSize',6);
hold on
%plot(x2,lc2-min(lc2),'color',[0 .75 0]);
plot(GF_lc1,'.r');legend('LC data','Gaussian Fit');
strNtotl=['N_t_o_t^+(0)=',num2str(round(Rgh_NTotl))];
text(-.9,max(lc1)*.6,strNtotl,'FontSize',12,'FontWeight','bold');
xlabel('\alpha','FontSize',16,'FontWeight','bold');
ylabel('LC','FontSize',16,'FontWeight','bold');
print(newFileName,'-dpng');
%plot(GF_lc2,'b');
savefig(res2)
save(res)
hold off