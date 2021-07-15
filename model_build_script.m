%% Kinesiology 531 Final Prokject
% Author: Kevin Krieg
% Import Data
data_import_script

% Exploratory Visualization Attempts
prev_sec = zeros(100);
next_sec = zeros(100);

hz_count = (1:length(TimeStamp));
plot(hz_count,imuAccelerationup,'b');
xlabel('Hz');
ylabel('Vertical Acceleration (G)');
hold on 

jump_values = zeros(length(jump_hz));
for i=1:length(jump_hz)
    jump = hz_count(jump_hz(i)):hz_count(jump_hz(i)+100);
    jump_values = imuAccelerationup(jump);
    plot(jump,jump_values,'r*');
end
legend('Accelerations','Jump')

