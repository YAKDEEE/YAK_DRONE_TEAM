function is_Complete = TurnAngle(obj,targetAngle)
%targetAngle 매개변수는 targetAngle만큼 yaw제어를 합니다.
    try
        turn(obj.mDrone,deg2rad(targetAngle));
        is_Complete = true;
    catch
        is_Complete= false;
    end
   
end

