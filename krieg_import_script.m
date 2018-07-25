%% Import jumpshot sensor data
filename = 'Jumpshot_Data.csv';
delimiter = ',';
startRow = 5;

% Format of columns
formatSpec = '%s%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%s%s%s%s%s%s%f%s%s%s%f%[^\n\r]';

fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

fclose(fileID);

% Create vector for each variable
TimeStamp = dataArray{:, 1};
Accelerationforward = dataArray{:, 2};
Accelerationside = dataArray{:, 3};
Accelerationup = dataArray{:, 4};
Rotationroll = dataArray{:, 5};
Rotationpitch = dataArray{:, 6};
Rotationyaw = dataArray{:, 7};
RawPlayerLoad = dataArray{:, 8};
SmoothedPlayerLoad = dataArray{:, 9};
imuAccelerationforward = dataArray{:, 10};
imuAccelerationside = dataArray{:, 11};
imuAccelerationup = dataArray{:, 12};
imuOrientationforward = dataArray{:, 13};
imuOrientationside = dataArray{:, 14};
imuOrientationup = dataArray{:, 15};
Facing = dataArray{:, 16};
Latitude = dataArray{:, 17};
Longitude = dataArray{:, 18};
Odometer = dataArray{:, 19};
RawVelocity = dataArray{:, 20};
SmoothedVelocity = dataArray{:, 21};
GNSSLPSAcceleration = dataArray{:, 22};
MetabolicPower = dataArray{:, 23};
GNSSFix = dataArray{:, 24};
GNSSStrength = dataArray{:, 25};
GNSSHDOP = dataArray{:, 26};
HeartRate = dataArray{:, 27};


% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;
%% Import Time stamp data
filename = 'Jumpshot_Timestamps.csv';
delimiter = ';';
startRow = 2;

formatSpec = '%s%s%s%s%f%[^\n\r]';


fileID = fopen(filename,'r');

dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);


fclose(fileID);

jump_Category = dataArray{:, 1};
jump_Movement = dataArray{:, 2};
jump_VideoTime = dataArray{:, 3};
jump_DataTime = dataArray{:, 4};
jump_hz = dataArray{:, 5};

% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;