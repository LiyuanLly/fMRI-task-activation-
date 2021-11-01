% figure the stimulation 2018.12.4 
% modify: 0,1 justify error has solved.
clc;clear;
data_all=xlsread('D:\mri_data\Job2_task\original_data\behavior\run1\GAD\all-run1-GAD.xlsx');
num=size(data_all,1)/60;
result=cell(num,2); % 11 stand for chongtu; 22 stand for yizhi; 3 stand for error.
stimulation=data_all(:,4);
acc=data_all(:,7);
rt=data_all(:,9);  
type=data_all(:,6); %type stand for mark;
for i=1:num
    start=1+(i-1)*60;
    cur_sti=stimulation(start:start+59);
    cur_sti=cur_sti/1000;
    cur_acc=acc(start:start+59);
    cur_rt=rt(start:start+59);
    cur_type=type(start:start+59);
    sti_no=zeros(60,1);
    if sum(cur_acc)<30
        ind_1=find(cur_acc==0);
        ind_2=find(cur_acc==1);
        cur_acc(ind_1)=1;
        cur_acc(ind_2)=0;
    end
    for j=1:59
        sti_no(j+1)=sti_no(j)+cur_sti(j);
    end
%     type_1=find(cur_acc==0); 
%     type_2=find(cur_rt<=100);
%     rt_m=mean(cur_rt);rt_sd=std(cur_rt);  type_3=find(cur_rt>=(rt_m+3*rt_sd));
%     type_12=union(type_1,type_2);type_all_3=union(type_12,type_3);
%     type_reverse=setdiff(1:60,type_all_3);%%排除错误的时间点
    type_all_1=find(cur_type==11);%type_all_1=setdiff(type_all_1,type_all_3);
    type_all_2=find(cur_type==22);%type_all_2=setdiff(type_all_2,type_all_3);
    result{i,1}=sti_no(type_all_1);result{i,2}=sti_no(type_all_2);%result{i,3}=sti_no(type_all_3);
end
save('D:\2018depression_AVemotion\gPPI\MDD_run2_stimulation.mat','result');
