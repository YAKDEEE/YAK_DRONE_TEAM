function is_Complete = MovetoLocation(obj,time,is_roll)
%time 매개변수는 드론이 time 초 동안 이동합니다.
%is_roll은 boolean으로, true면 roll제어, false면 fitch 제어로 이동합니다.
%output은 에러가 없을시 true, 에러발생시 false.
    try
        if (is_roll)
            moveleft(obj.mDrone, time,"Speed",0.5);
        else
            moveforward(obj.mDrone,time,"Speed",0.5);
        end
    
        is_Complete = true;
    catch
        fprintf("에러발생!\n");
        is_Complete = false;
    end

end



