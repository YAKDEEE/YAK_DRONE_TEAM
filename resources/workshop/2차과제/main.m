%% This is Main Section
% 2차 과제를 위한 메인 섹션입니다. 과제 해결은 이 섹션만 실행해주세요. 

my_Drone = YakDrone();
nError_code = my_Drone.Run();

if(nError_code)
    fprintf("에러코드 : %d\n",nError_code);
else
    fprintf("미션성공\n");
end


%% Disconnect Tello Drone
% Main Section 실행 이후 연결세션이 유지되어 Main Section이 실행시 연결 오류가 발생할때 실행해주세요.
clear my_Drone;

%% Emergency Landing
% Main Section 실행과정에서 에러 발생시 정상적으로 끝나지 않고 공중에 떠있게 되었을때, 강제적으로 착륙시킵니다.
% my_Drone.Finish();

