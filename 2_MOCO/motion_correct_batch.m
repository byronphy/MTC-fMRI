%-----------------------------------------------------------------------
% Job saved on 17-Sep-2024 19:42:56 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear;

cd '/Func';

gunzip(fullfile(pwd,'tMT_ON.nii.gz'));
gunzip(fullfile(pwd,'tMT_OFF.nii.gz'));

fileID=fopen(['NT.txt'],'r');
nTRs=fscanf(fileID,'%f');
fclose(fileID);

files=[dir(['tMT_ON.nii']),dir(['tMT_OFF.nii'])];
data = cell(length(files),1);
%%
for runs = 1:length(files)

    nTR  = nTRs(runs);
    base = files(runs).name;

    vols = cell(nTR,1);
    for TR = 1:nTR
        vols{TR} = [base ',' num2str(TR)];
    end
    data{runs} = vols;   % 
end

%% 
matlabbatch{1}.spm.spatial.realign.estwrite.data = data;

matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep     = 1.2;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm    = 1;

% 
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm     = 1;  
% 

matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp  = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap    = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight  = '';

matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which   = [2 1];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp  = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap    = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask    = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix  = 'r';

spm('defaults','FMRI');
spm_jobman('initcfg');
spm_jobman('run',matlabbatch);
exit;
