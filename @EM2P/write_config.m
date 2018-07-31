function flag = write_config(obj, path_file)
%% what does this function do 
%{
    write the configurations to a YAML file 
%}

%% inputs: 
%{
    path_file: the yaml file 
%}

%% outputs: 
%{
    flag: boolean, success (1) or not (0) 
%}

%% author: 
%{
    Pengcheng Zhou 
    Columbia University, 2018 
    zhoupc1988@gmail.com
%}

%% code 
warning('off', 'MATLAB:structOnObject'); 
x = struct(obj);

% useful configurations 
temp = fieldnames(x); 
useful_fields = {'yaml_path', ...
    'output_folder', ...
    'matfile_video', ...
    'video_shifts', ...
    'video_zvals', ...
    'video_zvals_updated', ...
    'video_Fs', ...
    'video_T', ...
    'denoised_folder', ...
    'raw_folder', ...
    'use_denoise', ...
    'matfile_stack', ...
    'stack_shifts', ...
    'matfile_transformation', ...
    'd1', ...
    'd2', ...
    'd3', ...
    'extra_margin', ...
    'FOV', ...
    'FOV_stack', ...
    'align_max_zshift', ...
    'num_scans', ...
    'num_slices', ...
    'num_blocks', ...
    'dims_stack', ...
    'dims_video', ...
    'range_2p', ...
    'scan_id', ...
    'slice_id', ...
    'block_id', ...
    'options_init', ...
    'init_method', ...
    'show_init', ...
    'pause_init', ...
    'maxIter_init', ...
    'show_em_only', ...
    'match_mask', ...
    'matfile_em', ...
    'em_shifts', ...
    'em_load_flag', ...
    'em_zblur', ...
    'PACK_SIZE', ...
    'score_method', ...
    'nam_show'}; 
x = struct(); 
for m=1:length(useful_fields)
    tmp_var = useful_fields{m}; 
    eval(sprintf('x.%s=obj.%s; ', tmp_var, tmp_var)); 
end
warning('on', 'MATLAB:structOnObject'); 

% check the input arguments
if ~exist('path_file', 'var') || isempty(path_file) 
    path_file = obj.yaml_path;
else
    x.yaml_path = path_file; 
end

try 
    yaml.WriteYaml(path_file, x); 
    flag = true; 
    fprintf('The configurations have been dumped to YAML file\n%s\n', path_file); 
catch 
    flag = false; 
    fprintf('Writing configurations to a YAML file failed\n'); 
end 