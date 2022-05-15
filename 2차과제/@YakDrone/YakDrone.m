classdef YakDrone
    properties
        mDrone; %ryze 객체
        mCam; %추후 사용
    end

    methods 
        function obj = YakDrone()
            obj.mDrone = ryze(); %드론 컨트롤을 위한 객체 선언
        end

        
        is_Complete = MovetoLocation(obj,time,is_roll);
        is_Complete = TurnAngle(obj,targetAngle);
        nErr_code = Run(obj);
        Finish(obj);
    end
end

