
%-----------------------------------------------------------------------
% Job saved on 27-Nov-2019 17:58:10 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clc;clear;
path='D:\2018depression_AVemotion\2020activation_recalculation\preprocessing2_37V37\run2\HC\FunImgARWS_3D_37V37';
out='D:\2018depression_AVemotion\2020activation_recalculation\onelevel2_work5_37V37_spm88\run2\HC';
sub=dir(path);sub=sub(3:end);
number=size(sub,1);
realigndir='D:\2018depression_AVemotion\2020activation_recalculation\preprocessing2_37V37\run2\HC\RealignParameter_37V37';
headmotion=dir(realigndir);headmotion=headmotion(6:end);

load 'D:\2018depression_AVemotion\2020activation_recalculation\stimulation_work45_37_37\HC_run2_stimulation.mat';%onset tiome
sti=result;
for iii=1:number    
    Name=sub(iii).name;
    outnew = [out,filesep,Name]; %create folders for each paticipants
    if ~isdir(outnew) 
        mkdir(outnew)
    end     
    
matlabbatch{1}.spm.stats.fmri_spec.dir = {outnew};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
%% input scans
datadir=[path,filesep,Name];
Img=dir(datadir);Img=Img(3:end);
 taskvar.run2.scan = cell(0);
 for iImg = 1:length(Img)
      taskvar.run2.scan= cat(1,taskvar.run2.scan,{[datadir,filesep,Img(iImg).name,',1']});
end
matlabbatch{1}.spm.stats.fmri_spec.sess.scans = taskvar.run2.scan;

%% conditions
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).name = 'chongtu';
onset_1=sti{iii,1};
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).onset = [onset_1];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).duration = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).name = 'yizhi';
onset_2=sti{iii,2};
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).onset = [onset_2];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).duration = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).orth = 1;

matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
%% regress the headmotion
cur_headmtion=dir([realigndir,filesep,headmotion(iii).name]);
txt=textread([realigndir,filesep,headmotion(iii).name,filesep,cur_headmtion(end-1).name]);
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = {[realigndir,filesep,headmotion(iii).name,filesep,cur_headmtion(end-1).name ]};
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
%%
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
matlabbatch{1}.spm.stats.fmri_spec.mask = {'D:\soft\DPABI_V3.0_171210\Templates\GreyMask_02_61x73x61.img,1'};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';

 %% Model estimation
matlabbatch{2}.spm.stats.fmri_est.spmmat = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
%% Contrast Manager3
% matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
% matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'chongtu';
% matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 0 0 0 0 0 0 0];
% matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
% matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'yizhi';
% matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [0 1 0 0 0 0 0 0];
% matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
% matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'chongtu_yizhi';
% matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = [1 -1 0 0 0 0 0 0];
% matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
% matlabbatch{3}.spm.stats.con.delete = 0;
%%
spm_jobman('initcfg');    
spm_jobman('run',matlabbatch);
    
clear outnew matlabbatch SPMpath
end


%%copy con.nii to new
clc;clear;
path='D:\2018depression_AVemotion\2020activation_recalculation\onelevel2_work5_37V37_spm8\run2\HC';
out1='D:\2018depression_AVemotion\2020activation_recalculation\onelevel2_work5_aftercopy_37V37\run2\chongtu\HC';
out2='D:\2018depression_AVemotion\2020activation_recalculation\onelevel2_work5_aftercopy_37V37\run2\yizhi\HC';
out3='D:\2018depression_AVemotion\2020activation_recalculation\onelevel2_work5_aftercopy_37V37\run2\chongtu_yizhi\HC';
path_dir=dir(path);path_dir=path_dir(3:end);
for i=1:size(path_dir,1)
    Name=path_dir(i).name;
    outnew1 = [out1,filesep,Name];
    if ~isdir(outnew1)
        mkdir(outnew1)
    end   
    outnew2 = [out2,filesep,Name];
    if ~isdir(outnew2)
        mkdir(outnew2)
    end
    outnew3 = [out3,filesep,Name];
    if ~isdir(outnew3)
        mkdir(outnew3)
    end
    cur_dir1=dir([path,filesep,Name,filesep,'con*1.nii']);
    cur_dir2=dir([path,filesep,Name,filesep,'con*2.nii']);
    cur_dir3=dir([path,filesep,Name,filesep,'con*3.nii']);
    copyfile([path,filesep,Name,filesep,cur_dir1.name],outnew1);
    copyfile([path,filesep,Name,filesep,cur_dir2.name],outnew2);
    copyfile([path,filesep,Name,filesep,cur_dir3.name],outnew3);
end

