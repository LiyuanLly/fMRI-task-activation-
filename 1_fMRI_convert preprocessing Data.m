% 4D --> 3D data
clear all;
clc;
path = 'D:\2018depression_AVemotion\2019kubi\run1_yjl\MDD\FunImgARWS\'; % 数据原始路径
pathTo = 'D:\2018depression_AVemotion\2019kubi\run1_yjl\MDD\FunImgARWS_3D\'; % 目标路径

temp = dir(path);
temp = temp(3 : end);

for i = 1 : length(temp)
    i
    dpath = [path,temp(i).name,filesep];
    dtemp = dir([dpath,'*nii']);
    [data,head] = rest_ReadNiftiImage([dpath,dtemp(1).name]);
    subTo = [pathTo,temp(i).name];
    mkdir(subTo);
    for j = 1 : size(data,4)
        if j < 10
            out = [subTo,filesep,'swra',temp(i).name,'_00',num2str(j)];
        elseif j < 100
            out = [subTo,filesep,'swra',temp(i).name,'_0',num2str(j)];
        else
            out = [subTo,filesep,'swra',temp(i).name,'_',num2str(j)];
        end
        rest_WriteNiftiImage(data(:,:,:,j),head,out);
    end
end