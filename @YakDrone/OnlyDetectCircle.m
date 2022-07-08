function is_Circle = OnlyDetectCircle(obj)
    
    is_Circle=0;
    try
  
        aBw = imcomplement(obj.aFiltered_blue); %반전 안시키면 바깥이 검은색이라서 구멍으로 인식 불가능함.
        aBw = bwareaopen(aBw,9);

        se = strel('disk',5);
        aBw = imerode(aBw,se);  
        
%         imshow(aBw);

        [B,L] = bwboundaries(aBw,'noholes');
        
        sStats = regionprops(L,'Area','Centroid','Eccentricity','MajorAxisLength','MinorAxisLength');
        
     
        nMax_sizeB = 0;
        
        for k = 1:length(B)
            aBoundary = B{k};
            [nSizeB,void] = size(aBoundary);
    
            nDelta_sq = diff(aBoundary).^2;    
            nPerimeter = sum(sqrt(sum(nDelta_sq,2)));
    
            nArea = sStats(k).Area;
            nMetric = 4*pi*nArea/nPerimeter^2;
       
            if nMetric > obj.cCircle_th
                if(nSizeB>10)
                    if(nSizeB<3000 && nSizeB>nMax_sizeB)
                        obj.aCentroid = sStats(k).Centroid;
                        obj.nEccentricity = sStats(k).Eccentricity;
                        obj.nCircle_r = mean([sStats(k).MajorAxisLength sStats(k).MinorAxisLength],2);
    
                        obj.aBestCircle = aBoundary;
                        is_Circle = 1;
                        
                        nMax_sizeB = nSizeB;
                    end
                end
            end
        end
    catch e
        disp(e)
        is_Circle=-1;
        
    end
end

