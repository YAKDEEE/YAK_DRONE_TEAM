function is_Complete= TurnAngle(obj)
    try
         if obj.nCount==3 
            turn(obj.mDrone,deg2rad(135));
            obj.MovetoLocation(-0.6,0);
            moveforward(obj.mDrone,"Distance",1.0,"Speed",obj.cSpeed_set);
         else
         
            turn(obj.mDrone,deg2rad(90));
            nDist_weight = obj.nMoveWeight*1.3;
            moveforward(obj.mDrone,"Distance",0.9+nDist_weight,"Speed",obj.cSpeed_set);
         end
        is_Complete=true;
    catch e
        disp(e);
        obj.Finish();
        is_Complete=false;
    end
end

