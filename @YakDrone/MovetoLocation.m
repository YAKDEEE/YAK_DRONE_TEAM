function is_Complete = MovetoLocation(obj,x,y)
    
    try
        move(obj.mDrone,[0 x -y],'Speed',obj.cSpeed_set);
        is_Complete = true;
    catch e
        disp(e)
        is_Complete=false;
    end
end

