% clear
% clc
% close all

%% load data

load('MNNRun_goodDisps.mat');
% 
% MNN_results = [goodDisps(4),goodDisps(12); goodDisps(8),goodDisps(16)];
% 
% [fileList, dataPath] = uigetfile('*.mat','Select Result Structure','MultiSelect', 'on');
% load([dataPath,fileList]);


%% Camera Rotation Calibration

% camera block width
camerawidth = 101.73; % mm

% bottom camera
bottom_bottomgap = 6.95; % mm
bottom_topgap = 11.81; % mm
bottom_gap = bottom_topgap - bottom_bottomgap;
theta1 = atan2(bottom_gap,camerawidth);


% top camera
top_bottomgap = 7.93; % mm
top_topgap = 7.41; % mm
top_gap = top_topgap - top_bottomgap;
theta2 = atan2(top_gap,camerawidth);

% matrices to invert camera rotation
rot1 = [cos(-theta1) -sin(-theta1);
        sin(-theta1) cos(-theta1)];
rot2 = [cos(-theta2) -sin(-theta2);
        sin(-theta2) cos(-theta2)];


%% plot full datasets
figure 
hold on
plot(goodDisps(4),goodDisps(12),'r*')
plot(CoMArray(:,3),-CoMArray(:,2),'b.')
figure 
hold on
plot(goodDisps(8),goodDisps(16),'r*')
plot(CoMArray(:,5),-CoMArray(:,4),'b.')

figure
hold on
plot(CoMArray(:,3))
plot(-CoMArray(:,2))
figure
hold on
plot(CoMArray(:,5))
plot(-CoMArray(:,4))



%% plot results

% pont indices
startZZ = 240;
endZZ = 290;
% zero indices
startPP = 350;
endPP = 420;

% compute mean zero values
meanZx2 = mean(CoMArray(startZZ:endZZ,5));
meanZy2 = mean(-CoMArray(startZZ:endZZ,4));
meanZx1 = mean(CoMArray(startZZ:endZZ,5));
meanZy1 = mean(-CoMArray(startZZ:endZZ,2));

% compute mean displacements
meanPx2 = mean(CoMArray(startPP:endPP,5));
meanPy2 = mean(-CoMArray(startPP:endPP,4));
meanPx1 = mean(CoMArray(startPP:endPP,5));
meanPy1 = mean(-CoMArray(startPP:endPP,2));

% compute vectors for displacement line of actions 
Lx1 = rot1*(-meanZx1+[meanZx1; meanPx1]);
Ly1 = rot1*(-meanZy1+[meanZy1; meanPy1]);
Lx2 = rot2*(-meanZx2+[meanZx2; meanPx2]);
Ly2 = rot2*(-meanZy2+[meanZy2; meanPy2]);

Vx1 = linspace(Lx1(1), Lx1(2), 1000);
Vy1 = linspace(Ly1(1), Ly1(2), 1000);
ERR1 = (Vx1-goodDisps(4)).^2 + (Vy1-goodDisps(12)).^2;
[MSE1, besterr1] = min(ERR1);

Vx2 = linspace(Lx2(1), Lx2(2), 1000);
Vy2 = linspace(Ly2(1), Ly2(2), 1000);
ERR2 = (Vx2-goodDisps(8)).^2 + (Vy2-goodDisps(16)).^2;
[MSE2, besterr2] = min(ERR2);

MSE = mean([MSE1,MSE1])


figure 
hold on
plot(Vx1(besterr1),Vy1(besterr1),'g*','MarkerSize',10,'LineWidth',2)
plot(goodDisps(4),goodDisps(12),'b*','MarkerSize',10,'LineWidth',2)
plot(0,0,'k*','MarkerSize',10,'LineWidth',2)
plot(0.2,-0.2,'r*','MarkerSize',10,'LineWidth',2)
axis([-0.4 0.4 -0.4 0.4])
grid on
set(gca,'fontsize', 18);
% title('Bottom Node')
% xlabel('x [mm]')
% ylabel('y [mm]')

figure 
hold on
plot(Vx2(besterr2),Vy2(besterr2),'g*','MarkerSize',10,'LineWidth',2)
plot(goodDisps(8),goodDisps(16),'b*','MarkerSize',10,'LineWidth',2)
plot(0,0,'k*','MarkerSize',10,'LineWidth',2)
plot(0.2,0.2,'r*','MarkerSize',10,'LineWidth',2)
axis([-0.4 0.4 -0.4 0.4])
grid on
set(gca,'fontsize', 18);
% title('Top Node')
% xlabel('x [mm]')
% ylabel('y [mm]')



%% plot results
% 
% startPP = 720;
% endPP = 870;
% 
% startZZ = 510;
% endZZ = 660;
% 
% x1 = (CoMArray(startPP:endPP,5) - CoMArray(startZZ:endZZ,5)) .* scale .* cameraScale1 .* forceScale;
% y1 = -(CoMArray(startPP:endPP,4) - CoMArray(startZZ:endZZ,4)) .* scale .* cameraScale1;
% 
% x2 = (CoMArray(startPP:endPP,3) - CoMArray(startZZ:endZZ,3)) .*scale .* cameraScale2 .* forceScale;
% y2 = -(CoMArray(startPP:endPP,2) - CoMArray(startZZ:endZZ,2)) .* scale .* cameraScale2;
% 
% figure 
% hold on
% plot(x1,y1,'g.')
% plot(goodDisps(4),goodDisps(12),'b*')
% plot(0,0,'k*')
% plot(0.2,0.2,'r*')
% axis([-0.5 0.5 -0.5 0.5])
% grid on
% title('Bottom Node')
% xlabel('x [mm]')
% ylabel('y [mm]')
% 
% figure 
% hold on
% plot(x2,y2,'g.')
% plot(goodDisps(8),goodDisps(16),'b*')
% plot(0,0,'k*')
% plot(0.2,-0.2,'r*')
% axis([-0.5 0.5 -0.5 0.5])
% grid on
% title('Top Node')
% xlabel('x [mm]')
% ylabel('y [mm]')
% 
% figure 
% hold on
% plot(mean(x1),mean(y1),'g*')
% plot(goodDisps(4),goodDisps(12),'b*')
% plot(0,0,'k*')
% plot(0.2,0.2,'r*')
% axis([-0.5 0.5 -0.5 0.5])
% grid on
% title('Bottom Node')
% xlabel('x [mm]')
% ylabel('y [mm]')
% 
% figure 
% hold on
% plot(mean(x2),mean(y2),'g*')
% plot(goodDisps(8),goodDisps(16),'b*')
% plot(0,0,'k*')
% plot(0.2,-0.2,'r*')
% axis([-0.5 0.5 -0.5 0.5])
% grid on
% title('Top Node')
% xlabel('x [mm]')
% ylabel('y [mm]')
% 
