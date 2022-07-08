function is_Complete= TurnAngle(obj)
    try
        turn(obj.mDrone,deg2rad(90));
        nDist_weight = obj.nMoveWeight*1.3;
        moveforward(obj.mDrone,"Distance",0.9+nDist_weight,"Speed",obj.cSpeed_set);
        is_Complete=true;
    catch e
        disp(e);
        is_Complete=false;
    end
end

