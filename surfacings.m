%McQuarrie 2021, running scripts at surfacings to model sound speed
%   profiles and sound propagation. Written to support NSF's Smart and 
%   Autonomous systems project, setting probability of detection given
%   environmental variables. Quick and Easy.

%Data directory that holds nbd. Change as needed.
datadir  = 'C:\Users\fmm17241\OneDrive - University of Georgia\data\Glider\Data\nbdasc\Test\';


%Reading data out of specific nbd
files = wilddir(datadir, 'nbdasc');
nfile = size(files,1);
sstruct = read_gliderasc([datadir,files(nfile,:)]);



% Frank's data cleanup. Takes Slocum glider data from climbs and dives to a 
%   matrix of values for the mission.
[dn,temperature,salt,density,depth,speed]=beautifyData(sstruct);


%%  Defining single profile, creating a soundspeed profile
[yoSSP,yotemps,yotimes,yodepths,yosalt,yospeed] = yoDefinerAuto(dn, depth, temperature, salt, speed);


% Creates and uses Bellhop Environmental File. Saves environmental file, rayfile, and plots
%   a Bellhop model into a directory chosen in CreateEnv.
%Directory to put all files; change as needed.
directory = (localPlots);

%Full ray tracing, show all
[waterdepth,beamFile] = ModelSoundSingle(yoSSP,directory, datadir);

% Beam Density Analysis, quantifying the sound pathways down range
[gridpoints, gridrays, sumRays] = bdaSingle(beamFile, directory);

% Beam Density Plot, visualization of the beam density analysis
bdaPlotSingle(beamFile,gridpoints,sumRays)


% Outputspercentage of rays reaching
%   set distances down range, and by proxy estimates detection efficiency.
[percentage]=writeBDAoutput(sumRays,gridpoints);



