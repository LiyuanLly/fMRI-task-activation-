clear all;
clc;
%-----------------------------------------------------------------------
matlabbatch{1}.spm.stats.factorial_design.dir = {'D:\2018depression_AVemotion\2020activation_recalculation\result2\work5_PPI_flexiblefac\PPI_ROI4_mPFC_L\test'};
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).name = 'subject';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).name = 'HCMDD';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).name = 'run12';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).dept = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).ancova = 0;
%-------strong_data--------
data1 = 'D:\2018depression_AVemotion\2020activation_recalculation\onelevel2_work5_37V37_ppi_nocontrast_spm8_aftercopy\PPI_ROI4_mPFC_L';
Runtype1 = 'run1';
Runtype2 = 'run2';
SubjectType1 = 'HC';
sub1_run1 = dir([data1 '\' Runtype1 '\chongtu_yizhi\' SubjectType1 '\chen*.img']);
sub1_run2 = dir([data1 '\' Runtype2 '\chongtu_yizhi\' SubjectType1 '\chen*.img']);
for i = 1:length(sub1_run1)
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(i).scans = {
                                                                                      [data1,'\',Runtype1, '\chongtu_yizhi\', SubjectType1,'\',sub1_run1(i).name,',1']
                                                                                      [data1,'\',Runtype2, '\chongtu_yizhi\', SubjectType1,'\',sub1_run2(i).name,',1']
                                                                                      };
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(i).conds = [1 1
                                                                                      1 2];
end
%------weak_data---------
SubjectType2 = 'MDD';
sub2_run1 = dir([data1 '\' Runtype1 '\chongtu_yizhi\' SubjectType2 '\chen*.img']);
sub2_run2 = dir([data1 '\' Runtype2 '\chongtu_yizhi\' SubjectType2 '\chen*.img']);
for j = 1:length(sub2_run1)
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(length(sub1_run1)+j).scans = {
                                                                                         [data1,'\',Runtype1, '\chongtu_yizhi\', SubjectType2,'\',sub2_run1(j).name,',1']
                                                                                      [data1,'\',Runtype2, '\chongtu_yizhi\', SubjectType2,'\',sub2_run2(j).name,',1']  
                                                                                         };
    matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(length(sub1_run1)+j).conds = [2 1
                                                                                         2 2];
end
%--------主效应、交互效应--------
matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.fmain.fnum = 1; %主效应只能选subject
matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{2}.inter.fnums = [2
                                                                                  3];%group × yinjie
%-------回归协变量--------
% %先手动填入每个被试的协变量
% sex1 = [];
% age1 = [];
% edu1 = [];
% sex = [];
% age = [];
% edu = [];
% for k = 1:46
%     t = k-1;
%     sex((3*t+1):(3*t+3),1) = sex1(k);
%     age((3*t+1):(3*t+3),1) = age1(k);
%     edu((3*t+1):(3*t+3),1) = edu1(k);
% end
% save('F:\McGurk\2019pt_HXJ\result\strong26_weak20\Flexible factorial\BrainMask_regress age,sex,edu\sex.mat','sex');
% save('F:\McGurk\2019pt_HXJ\result\strong26_weak20\Flexible factorial\BrainMask_regress age,sex,edu\age.mat','age');
% save('F:\McGurk\2019pt_HXJ\result\strong26_weak20\Flexible factorial\BrainMask_regress age,sex,edu\edu.mat','edu');
%以后就可以直接load
load('D:\2018depression_AVemotion\2020activation_recalculation\result2\work5_PPI_flexiblefac\PPI_ROI4_mPFC_L\cov_flexiblefactorial.mat');
load('D:\2018depression_AVemotion\2020activation_recalculation\result2\work5_PPI_flexiblefac\PPI_ROI4_mPFC_L\cov_flexiblefactorial_MD.mat');
matlabbatch{1}.spm.stats.factorial_design.cov(1).c = cov_sex;
matlabbatch{1}.spm.stats.factorial_design.cov(1).cname = 'sex';
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).c = cov_sex;
matlabbatch{1}.spm.stats.factorial_design.cov(2).cname = 'age';
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(3).c = cov_sex;
matlabbatch{1}.spm.stats.factorial_design.cov(3).cname = 'edu';
matlabbatch{1}.spm.stats.factorial_design.cov(3).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(3).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(4).c = cov_MD;
matlabbatch{1}.spm.stats.factorial_design.cov(4).cname = 'MD';
matlabbatch{1}.spm.stats.factorial_design.cov(4).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(4).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {'D:\2018depression_AVemotion\2020activation_recalculation\result2\work5\onesamplet_HCMDD_noxiaonao\masks_run12\run12_HCMDD_mask.nii,1'};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
%-----------------------------------------------------------------------
spm_jobman('initcfg');
spm_jobman('run', matlabbatch);
