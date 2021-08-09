%% Kinesiology 531 Final Project
% Author: Kevin Krieg
% Import Data
krieg_import_script

% Exploratory Visualization Attempts

hz_count = (1:length(TimeStamp));
plot(hz_count,Accelerationup,'b');
xlabel('Frequency (Hz)');
ylabel('Vertical Acceleration (G)');
hold on
j_aup = zeros(30,101);
jump_values = zeros(length(jump_hz));
jumps = zeros(30,100);
for i=1:length(jump_hz)
    jump = hz_count(jump_hz(i)):hz_count(jump_hz(i)+99);
    jumps(i,:) = jump;
    jump_values = Accelerationup(jump);
    %j_aup(i,:) =  jump_values;
    plot(jump,jump_values,'r*');
end
legend('Accelerations','Jump')





%% Filtering

% Remove contribution of gravity and filter to center around zero
freq = 100;
f_stop = 0.4;
f_pass = 0.8;
a_stop = 60;
a_pass = 1;

h = fdesign.highpass(f_stop,f_pass,a_stop,a_pass,freq);
Hd = design(h, 'cheby2','MatchExactly','passband');
filt_up = filter(Hd,Accelerationup);
filt_side = filter(Hd,Accelerationside);
filt_forward = filter(Hd,Accelerationside);
filt
% Plot Pre and Post filter vertical acceleration data to show filtering
figure
plot(hz_count,Accelerationup,'b');
xlabel('Frequency Hz');
ylabel('Vertical Acceleration (G)');
hold on
plot(hz_count,filt_up,'r');
legend('Raw Data','Filtered')

%% Prepare Data for Classification

%Chop x,y,z acceleration vectors into 100 observation chunks, with 50 point overlap
up = buffer(filt_up,100)';
side = buffer(filt_side,100)';
forward = buffer(filt_forward,100)';
features = zeros(length(up),9);

%Feature Extraction
for i = 1:length(up)
%find mean of each axis stream
mean_x = mean(forward(i,:));
mean_y = mean(side(i,:));
mean_z = mean(up(i,:));

%find covariance of each axis stream
cov_x = cov(forward(i,:));
cov_y = cov(side(i,:));
cov_z = cov(up(i,:));

%find standard deviation of each axis stream
sd_x = std(forward(i,:));
sd_y = std(side(i,:));
sd_z = std(up(i,:));

features(i,:) = [mean_x mean_y mean_z cov_x cov_y cov_z sd_x sd_y sd_z];

end

%Convert data to table with header names
features = array2table(features,'VariableNames',{'mean_x', 'mean_y', 'mean_z', 'cov_x', 'cov_y', 'cov_z', 'sd_x', 'sd_y', 'sd_z'});

%Create jump shot labels
labels = cell(size(features,1),1);
labels(:) = {'Non-JumpShot'};

%Get indicies of jump shots
jump_idx = jumps(:,1)/100;

%Label JumpShots
for L = 1:length(jump_idx)
labels{jump_idx(L)} = 'JumpShot';
end


%Alternative Labeling for Shot Category
%for L = 1:length(jump_idx)
%labels{jump_idx(L)} = char(jump_Category(L));
%end

%Alternative Labeling for Pre-Shot Movement
%for L = 1:length(jump_idx)
%labels{jump_idx(L)} = char(jump_Movement(L));
%end

features.Label = labels;
