function nError_code = Run(obj)
%과제수행을 위한 실행 함수.
%output은 미션 완료시 0, N번째 단계에서 에러 발생시 숫자 N 출력(Error code)
    takeoff(obj.mDrone);
    
    pause(3);
    nError_code = 0;

    if(~(obj.MovetoLocation(3,true)))
        nError_code = 1;
        obj.Finish();
        return
    end

    if(~(obj.TurnAngle(37)))
        
        nError_code = 2;
        obj.Finish();
        return
    end

    if(~(obj.MovetoLocation(5,false)))
        
        nError_code = 3;
        obj.Finish();
        return
    end

    if(~(obj.TurnAngle(147)))

        nError_code = 4;
        obj.Finish();
        return
    end

    if(~(obj.MovetoLocation(4,false)))
        nError_code = 5;
        obj.Finish();
        return
    end
      
    fprintf("\n실행완료\n");
    obj.Finish();
    return
end

