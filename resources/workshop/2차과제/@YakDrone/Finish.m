function Finish(obj)
    %드론을 착륙시키고 드론 객체를 지웁니다.
  
    land(obj.mDrone);
    clear obj.mDrone;

end

