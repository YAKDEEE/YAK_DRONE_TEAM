# YakDrone
 ### 대한전기학회, Mathworks Korea, 광운대학교 공동 주최 2022 미니드론 대회 본선 진출 팀 “약둘기”의 드론 제어 클래스입니다.
 <img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/NormalYAK.png" width="698px" height="601px" alt="NormalYAK"></img>

# 주의점!!
### matlab 현재 폴더가 clone한 폴더인지 확인하세요! main.m을 스크립트를 실행하면 해당 프로젝트 코드가 실행됩니다!    
### 모든 멤버함수에는 try catch문이 적용되어 있습니다. 만약 드론이 비상착륙 했다면 에러 내용을 확인하세요!    

# Requirements
Image Processing Toolbox     
MATLAB Support Package for Ryze Tello Drones       
 
# Getting Started
### 아래 코드와 설명은 약둘기 팀이 어떤 알고리즘과 방법론을 적용했는지 이해하기 쉽도록 구성되었습니다.

①  설계 지향점과 방법론 제시     
②  변수 정의와 주요 Threshold 값 제시     
③  기능 흐름도 제시     
④  Architecture 및 알고리즘 흐름도 제시     
⑤  핵심 알고리즘 제시 및 전략 세부 설명     
⑥  설계시 마주한 문제점 및 해결방법     
⑦  개선 가능 사항     
⑧  Reference     

# Ⅰ. 설계 지향점과 방법론 
## 코드 유지와 보수, 디버그 및 효율적인 작동을 위하여 아래와 같은 지향점을 두었습니다.
①  객체지향 프로그래밍으로써 클래스 구조로 설계함.        
②  함수형 프로그래밍을 지향하여 여러 멤버함수의 조합으로 설계.       
③  한개의 Infinite Loop와 멤버변수, 멤버함수를 통한 드론 제어로써 메모리 최적화 및 효율성 극대화.       

## 예외 처리와 비상착륙
#### [발견된 문제점]      
불안정한 네트워크 상황 및 일시적인 이미지 캡처 실패로 인한 잘못된 참조로 에러가 발생할 경우 드론이 제자리에서 멈추게 되어 행동불능에 빠지는 경우가 있었음.     
#### [해결방법]      
모든 함수에 대해 Try catch 예외문으로 처리하여 문제 상황을 디버그 할 수 있었으며 동시에 드론을 착륙시켜 행동불능 상태에 빠지는 것을 방지함.

# Ⅱ. 변수 정의와 주요 임계값 설명
### 코드 관리를 위하여 변수 앞에 변수타입 태그를 같이 적음
> a 태그 : 해당 변수는 배열입니다. (ex: aConverted_HSV = RGB 이미지 배열을 HSV로 변환한 배열)
>      
> c 태그 : 해당 변수는 상수입니다. (임계값 등)     
> 
> n 태그 : 해당 변수는 numerical 변수입니다.      
> 
> is_ 태그 : 해당 변수는 boolean 변수입니다.        
> 

### 중요 멤버변수
> aFiltered_blue=[] → 파랑색을 검출한 배열     
> 
> aBestCircle=[] → 원형성이 가장 높은 원의 좌표값의 배열     
> 
> aCentroid=[] →  원형성이 가장 높은 원의 좌표값의 배열의 중심값 (원의 중심)    
>  
> cMin_blue_th = 0.595     
> 
> cMax_blue_th = 0.670     
> 
> nCount → 몇번째 원을 통과 해야하는지를 나타내는  변수      
> 
> nStep -> 몇번째 단계인지를 나타내는 변수     
> 
> nRatio -> 위, 아래 길이의 비율을 계산하는 변수(1에 가까울수록 완벽한 원)

# Ⅲ. 기능 흐름도
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/circlefind.png" width="450px" height="300px" alt="Step1"></img>
<br/><br/>
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/center.png" width="750px" height="500px" alt="Step2"></img>
<br/><br/>
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/centerfinder.png" width="1100px" height="450px" alt="Step2"></img>
<br/><br/>
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/turn.png" width="450px" height="310px" alt="Step3"></img><br/>
<br/><br/>

# Ⅳ. Architecture 및 알고리즘 흐름도

### ①Architecture
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/architecture.png" width="3000px" height="800px" alt="Arch"></img><br/>
<br/><br/>

### ②Flow Chart
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/flowchart.png" width="3100px" height="800px" alt="Flow"></img><br/>
<br/><br/>

# Ⅴ. 핵심 알고리즘 및 전략 설명.

## 1. 이미지 처리 방법
### (이미지 처리 알고리즘은 ImageProcessing 멤버함수와 OnlyDetectCircle 멤버함수 일부에 있습니다.)
① snapshot을 통해 받아온 RGB 사진은 HSV 로 변환됩니다.
<pre>
<code>
 aHSV_frame = rgb2hsv(aRaw_frame);
 </code>
 </pre>
 
② HSV로 변환된 3차원 배열 중에서 H, S, V를 각각 분리하여 H 필터를 통한 파란색 색상 이외 색상 필터링, S 필터를 통한 하얀색 색상 필터링, V 필터를 통한 검은색 색상 필터링을 진행합니다.    
<pre>
<code>
 sfilter = aHSV_frame(:,:,2) > obj.cFitler_S_weight;
 vfilter = aHSV_frame(:,:,3) > obj.cFitler_V_weight;
 obj.aFiltered_blue = ( obj.aConverted_HSV > obj.cMin_blue_th) & ( obj.aConverted_HSV < obj.cMax_blue_th);
 </code>
 </pre>
      
③ 모폴로지 팽창 연산을 적용하여 깔끔한 파란색 바이너리 영상을 얻습니다.
<pre>
<code>
 se = strel('disk',7);
 obj.aFiltered_blue = imdilate(obj.aFiltered_blue,se);
 obj.aFiltered_blue = round(obj.aFiltered_blue);
 </code>
 </pre>

④ 파란색 바이너리 영상에 보수를 취한후 모폴로지 침식 연산을 적용합니다.
<pre>
<code>
 aBw = imcomplement(obj.aFiltered_blue); 
 aBw = bwareaopen(aBw,9);
 se = strel('disk',5);
 aBw = imerode(aBw,se);  
 </code>
 </pre>
 
 
#### 모폴로지(Mopolgy) 연산이란?
모폴로지는  영상에서 객체의 형태 및 구조에 대해 분석하고 처리하는 기법을 의미합니다.       
     
모폴로지 팽창은 객체의 외곽을 확장시키는 연산입니다.     
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/dilation.png" width="450px" height="300px" alt="Nocircle"></img><br/>     
모폴로지 침식은 객체의 외곽을 깍아내는 연산입니다.     
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/erosion.png" width="450px" height="300px" alt="Nocircle"></img><br/>   
     
#### 아래는 실제 드론 영상에서 모폴로지 적용 전 후를 비교한 이미지 입니다.     
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/difference.png" width="450px" height="300px" alt="Nocircle"></img><br/>   

## 2. 원 찾기 전략.
### (원을 찾는 알고리즘은 OnlyDetectCircle 멤버함수에 있습니다.)
① 보수화된 파란색 이진화된 영상에 대하여 영역 경계선을 추적합니다.
<pre>
<code>
 [B,L] = bwboundaries(aBw,'noholes');
 </code>
 </pre>
② 닫힌 영역에 대하여 면적, 중심, 장축의 길이, 단축의 길이 를 찾아낸 후, Metric과 실제 영역을 비교하여 원과의 유사도를 찾습니다.    
그중에서 가장 크고 원과 가까운 영역의 중심, 장/단축의 길이를 멤버변수에 저장합니다.   

<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/metric.png" width="200px" height="100px" alt="Nocircle"></img><br/>
<pre>
<code>
sStats = regionprops(L,'Area','Centroid','MajorAxisLength','MinorAxisLength');
        ...
        
             if(nSizeB<3000 && nSizeB>nMax_sizeB)
                 obj.aCentroid = sStats(k).Centroid;

                 obj.nCircle_r = mean([sStats(k).MajorAxisLength sStats(k).MinorAxisLength],2);

                 obj.nRatio = sStats(k).MinorAxisLength / sStats(k).MajorAxisLength;
                 obj.aBestCircle = aBoundary;
                 is_Circle = 1;

                 nMax_sizeB = nSizeB;
             end
        ...
 end
 </code>
 </pre>
## Exception. 원이 검출 되지 않았을 경우    
### 경우1. 파란색조차 검출되지 않은 경우.
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/findingcircle.png" width="3100px" height="800px" alt="Nocircle"></img><br/>
    
### 경우2. 파란색이 일부 검출된 경우.     

<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/newfindingcircle.png" width="600px" height="600px" alt="Nocircle"></img><br/>
    
### 경우3. 파란색이 화면상에 완전히 채워져 있을 경우.
(파란색이 중앙에 있을경우는(완전히 드론 앞에 파란색이 있는 경우) 뒤로 움직이면서 거리를 벌립니다.)    
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/moveback.png" width="200px" height="350px" alt="Nocircle"></img><br/>   
    
## 3. 중심 맞추기 알고리즘 및 원 통과 전략
### 중심 맞추기 (중심을 찾고 이동하는 알고리즘은 Centerfinder 멤버함수에 있습니다.)
① 원의 중심의 좌표와 이미지 중앙의 좌표값의 차이만큼 드론을 원의 중심으로 최대한 이동시킵니다. 이때 이동할 거리는 아래의 비례식에 의하여 계산되었습니다.     
     
> R = 실제 원의 반지름(m)     
>    
> r = 픽셀상 반지름      
>     
> X = 픽셀당 실제 거리
>     
> d = 픽셀상 거리

![image](https://user-images.githubusercontent.com/51030319/178751971-f9dba81b-f750-48f5-8dbd-55bb4b3417e2.png)

<pre>
<code>
...    
  coeff = (obj.cCircle_size(1,obj.nCount)/(obj.nCircle_r/2.3));

  nTarget_X = round(coeff * nTarget_X,2);
  nTarget_Y = round(coeff * nTarget_Y,2);
...    
</code>
</pre>
     
### 거리 계산 및 
 ② 계산된 원의 반지름을 바탕으로 현재 원까지의 거리를 구합니다. 그 후 직진합니다.
     
<pre>
<code>
...
   Circle_r = obj.nCircle_r*(0.39/obj.cCircle_size(1,obj.nCount));

   nDistance = (515)*(Circle_r^(-0.954));
   dist = round(nDistance,2)+0.3;


   moveforward(obj.mDrone,"Distance",dist,"Speed",obj.cSpeed_set);
...
</code>
</pre>


## 4. 장,단축 비율에 따른 드론 회전각 계산 전략
### (주의!. 07.13일부로 현재 코드는 사용되지 않습니다. 이유는 후술)
세번째 원이 드론이 회전하는 각도에 따라 타원이 장축의 길이가 변화하므로 장축과 단축 사이의 각도를 아크탄젠트를 이용하여 회전각을 구하였습니다.
<pre>
<code>
try 
        obj.nMAxisLength;
        obj.nmAXislength;
        angle = atan(obj.nmAXislength/obj.nMAxisLength);
        angle = fix(angle);
        
        if(angle > 3)
            turn(obj.mDrone,deg2rad(90-angle));
        end
        is_Complete = true;
    catch e
        disp(e);
        is_Complete=false;
    end
</code>
</pre>
    
### [발견된 개선점]    
실제 경기장 3번째 원의 각도가 135도에서 진행시에도 전혀 문제가 없는 것으로 판단하였습니다. 따라서 위와 같은 코드는 속도면에서 비효율적이라 생각되어 보류했습니다.    
    
# Ⅵ. 설계시 마주한 문제점.
## 1. 최소 이동 거리 문제
### 표식의 빨간점이 잘 인식되지 않아 화면에서 보이는 원의 반지름을 구하여 원과 드론 사이의 거리를 구하는 식을 만들어 사용하였는데 팀에서 제작한 원의 크기가 정확하지 않고 식을 만드는 과정에서 약간의 오차가 있어 드론이 원을 통과한 후 일정거리 이상 직진하거나 일정거리까지 도달을 못하는 상황이 발생함.
### 드론이 원을 통과한후 일정거리 이상 직진한 후 원을 탐지하는 단계로 넘어가는데 원이 좌우는 움직임이 없고 뒤로 1m 떨어져 있고 원의 중심 높이가 드론의 고도와 비슷할 때 드론 화면에 원을 통과한 뒷배경이 검출되어 아무런 동작을 못하는 문제가 발생하였음. 

## 2. 멤버변수 오류
### YakDrone을 값 클래스로 사용하면 할당되는 변수를 원래 객체에 대한 독립적인 복사본을 생성하고, 이 변수를 수정하는 경우 수정된 객체를 출력인수로 반환할때 오류가 발생하여 핸틀 클래스를 사용하였음. 핸들 클래스는 핸들 객체를 여러 변수에 할당하거나 함수에 전달할 수 있으므로 원래 객체의 복사본을 생성하지 않아 핸들 객체를 수정하는 함수는 객체를 변환할 필요가 없어 오류가 발생하지 않음.


## 3. 드론의 카메라 위치에 따른 원 중심 Y값 Weights
### 드론의 카메라가 기체의 아래쪽에 위치하므로 드론이 원의 중심을 찾아 이동하여도 드론이 위로 치우치는 경향이 있어 Y값에 Weight를 설정하였음.

# Ⅶ. 개선 가능 사항
## 텔로 드론의 최소이동거리가 20cm로 주어진 원 크기에 비해 큰 경향이 있어, 원의 중심을 찾고 중심으로 이동하는 과정에서 정밀한 조정이 어려웠습니다. 이 부분을 해결하고자 각도를 변경한 후 대각선으로 이동하는 방법이 있었지만 시간이 늘어나는 단점이 있습니다.

# Ⅷ. Reference

Metrics 사진 출처 -    
https://kr.mathworks.com/help/images/identifying-round-objects.html    
     
Mopolgy 사진 출처 -     
https://velog.io/@redorangeyellowy/ch07-%EC%9D%B4%EC%A7%84-%EC%98%81%EC%83%81-%EC%B2%98%EB%A6%AC-%EB%AA%A8%ED%8F%B4%EB%A1%9C%EC%A7%80-1-%EC%B9%A8%EC%8B%9D%EA%B3%BC-%ED%8C%BD%EC%B0%BD     

https://kr.mathworks.com/help/images/ref/regionprops.html

https://bkshin.tistory.com/entry/OpenCV-19-%EB%AA%A8%ED%8F%B4%EB%A1%9C%EC%A7%80Morphology-%EC%97%B0%EC%82%B0-%EC%B9%A8%EC%8B%9D-%ED%8C%BD%EC%B0%BD-%EC%97%B4%EB%A6%BC-%EB%8B%AB%ED%9E%98-%EA%B7%B8%EB%A0%88%EB%94%94%EC%96%B8%ED%8A%B8-%ED%83%91%ED%96%87-%EB%B8%94%EB%9E%99%ED%96%87
