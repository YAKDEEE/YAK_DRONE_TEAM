# YakDrone
 ### 대한전기학회, Mathworks Korea, 광운대학교 공동 주최 2022 미니드론 대회 본선 진출 팀 “약둘기”의 드론 제어 클래스입니다.
 <img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/NormalYAK.png" width="698px" height="601px" alt="NormalYAK"></img>

# Requirements
Image Processing Toolbox     
MATLAB Support Package for Ryze Tello Drones       
 
# Getting Started
### 아래 코드와 설명은 약둘기 팀이 어떤 알고리즘과 방법론을 적용했는지 이해하기 쉽도록 구성되었습니다.
### 본 클래스는 Matlab 프로젝트로 작성되어 .prj 파일을 엶으로써 파일경로에 클래스 파일들을 추가할 수 있습니다.
①  설계 지향점과 방법론 제시     
②  변수 정의와 주요 Threshold 값 제시     
③  기능 흐름도 제시     
④  Architecture 및 알고리즘 흐름도 제시     
⑤  핵심 알고리즘 제시 및 전략 세부 설명     
⑥  설계시 마주한 문제점 및 해결방법     
⑦  개선 가능 사항     
⑧  Reference     

# Ⅰ. 설계 지향점과 방법론 
### 코드 유지와 보수, 디버그 및 효율적인 작동을 위하여 아래와 같은 지향점을 두었습니다.
①  객체지향 프로그래밍으로써 클래스 구조를 설계함.        
②  함수형 프로그래밍을 지향하여 여러 멤버함수의 조합으로 설계.       
③  Infinite Loop문을 한개만 두고 멤버변수를 통해 데이터를 저장함으로써 메모리 최적화 및 효율성 극대화.       

### 에러 처리와 비상착륙
#### [발견된 문제점]      
불안정한 네트워크 상황 및 일시적인 이미지 캡처 실패로 인한 잘못된 참조로 에러가 발생할 경우 드론이 제자리에서 멈추게 되어 행동불능에 빠지는 경우가 있었음.     
#### [해결방법]      
모든 함수에 대해 Try catch 예외문으로 처리하여 문제 상황을 디버그 할 수 있었으며 동시에 일시적인 문제에 대해서는 드론이 행동불능에 빠지지 않음. 

     
# Ⅱ. 변수 정의와 주요 임계값 설명
### 코드 관리를 위하여 변수 앞에 변수타입 태그를 같이 적음
> a 태그 : 해당 변수는 배열입니다. (ex: aConverted_HSV = RGB 이미지 배열을 HSV로 변환한 배열)     
> c 태그 : 해당 변수는 상수입니다. (임계값 등)     
> n 태그 : 해당 변수는 numerical 변수입니다.      
> is_ 태그 : 해당 변수는 boolean 변수입니다.        


### 중요 멤버변수
> aFiltered_blue=[] → 파랑색을 검출한 배열     
> aBestCircle=[] → 원형성이 가장 높은 원의 좌표값의 배열     
> aCentroid=[] →  원형성이 가장 높은 원의 좌표값의 배열의 중심값 (원의 중심)     
> cMin_blue_th = 0.595     
> cMax_blue_th = 0.670     
> nCount → 몇번째 원을 통과 해야하는지를 나타내는  변수      
> nStep -> 몇번째 단계인지를 나타내는 변수     

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

## 1. 원 찾기 전략.
### (원을 찾는 알고리즘은 OnlyDetectCircle 멤버함수에 있습니다.)
//파랑색의 HSV값을 이용해 이미지에서 파랑색을 검출하고, 모폴로지연산과 가우시안 필터를 이용해 잡음을 제거함. //

## Exception. 원이 검출 되지 않았을 경우
### (1번의 멤버함수에서 false 값이 5번 이상 나타난 경우)
<img src="https://github.com/YAKDEEE/YAK_DRONE_TEAM/blob/main/images/findingcircle.png" width="3100px" height="800px" alt="Nocircle"></img><br/>
## 파랑색이 검출되었을 경우 
### 화면에 잡히는 파란색 픽셀 x, y값의 중심위치를 계산하여 y값의 중심위치가 비교 값보다 아래쪽에 위치하였을 때 드론이 아래로 35cm 내려가게 하였고 반대의 경우에는 올라가게 설정함. x값의 중심위치가 오른쪽에 있을 때는 드론이 왼쪽으로 80cm이동하게 하였고 반대의 경우에는 오른쪽으로 이동하게 설정하여 원을 찾게 설정하였음.


## 2. 이미지 처리 방법
### (이미지 처리 알고리즘은 ImageProcessing 멤버함수와 OnlyDetectCircle 멤버함수 일부에 있습니다.)
#### //파랑색의 HSV값을 이용해 이미지에서 파랑색을 검출하고, 모폴로지연산과 가우시안 필터를 이용해 잡음을 제거함. // -> 삭제할수도있음
## 3. 중심 맞추기 알고리즘 및 원 통과 전략
### (해당 알고리즘은 CenterFinder 멤버함수에 있습니다.)
#### 중심 맞추기
##### 원의 중심의 좌표와 이미지 중앙의 좌표값의 차이만큼 드론을 원의 중심으로 최대한 이동시킴. 
드론이 이미지의 중앙 좌표값이 원의 중심좌표와 비슷하면 드론이 직진했을 때 원내부로 통과할 수 있다고 판단하여 드론에 직진 명령을 주어 원을 통과한다. 

#### 원 통과 전략
##### 원의 중심으로 이동을 하고나서 원과의 거리가 너무 가까워서 원이 탐지가 안되면 적당히 직진을 한다. 
(//대충 드론과 원과의 거리가 가까운 짤)//
원의 중심으로 이동하고 나서 원이 탐지가 되는 경우 화면에서 보이는 원의 반지름을 계산하여 원과 드론 사이의 간격을 계산할 수 있는 식을 만들어 사용하였음.

## ADD. 드론의 카메라 위치에 따른 원 중심 Y값 Weights
### 드론의 카메라가 기체의 아래쪽에 위치하므로 드론이 원의 중심을 찾아 이동하여도 드론이 위로 치우치는 경향이 있어 Y값에 Weight를 설정하였음.

## 4. 이심률에 따른 각도 계산 전략
### (해당 알고리즘은 ~~~)

# Ⅵ. 설계시 마주한 문제점.
## 1. 최소 이동 거리 문제
### 표식의 빨간점이 잘 인식되지 않아 화면에서 보이는 원의 반지름을 구하여 원과 드론 사이의 거리를 구하는 식을 만들어 사용하였는데 팀에서 제작한 원의 크기가 정확하지 않고 식을 만드는 과정에서 약간의 오차가 있어 드론이 원을 통과한 후 일정거리 이상 직진하거나 일정거리까지 도달을 못하는 상황이 발생함.
### 드론이 원을 통과한후 일정거리 이상 직진한 후 원을 탐지하는 단계로 넘어가는데 원이 좌우는 움직임이 없고 뒤로 1m 떨어져 있고 원의 중심 높이가 드론의 고도와 비슷할 때 드론 화면에 원을 통과한 뒷배경이 검출되어 아무런 동작을 못하는 문제가 발생하였음. 
## 2. snapshot 오류
### 2.1 HSV조정
#### HSV
파랑색의 H값만을 이용해 파랑색 천을 탐지했을 때 드론이 파랑색인 천말고 다른 물체들을 찾아서 파랑천을 탐지하기 쉽지 않았음. 그래서 파랑색 천의 S와 V값도 고려했음. 
(//H만을 사용했을 때 걸러지는거 vs SV 다같이 사용했을 때 걸러지는거 캡쳐) 차이 //
### 2.2 잡음처리  
잡음처리를 하지 않으면 파랑천밖의 파랑색으로 탐지된 잡음들이 생기고, 파랑천안의 몇몇 픽셀들이 탐지가 되지 않음. 이로인해 파랑천의 원을 탐지를 못하거나, 파랑천 바깥의 원을 탐지하는 문제점이 생겨 잡음처리가 필요해짐. 가우시안필터와 모폴로지연산을 통해 잡음을 제거했음.
//(가우시안필터 & 모폴로지연산 VS 아무것도 안한거 캡쳐 ) 
### 2.3 아예 안찍히거나 뭉개져서 나오는 경우. (이후 병찬이가 쓸거임)
#### 화면 하얗게 나오는경우 말하는거 


## 3. 멤버변수 오류
### YakDrone을 값 클래스로 사용하면 할당되는 변수를 원래 객체에 대한 독립적인 복사본을 생성하고, 이 변수를 수정하는 경우 수정된 객체를 출력인수로 반환할때 오류가 발생하여 핸틀 클래스를 사용하였음. 핸들 클래스는 핸들 객체를 여러 변수에 할당하거나 함수에 전달할 수 있으므로 원래 객체의 복사본을 생성하지 않아 핸들 객체를 수정하는 함수는 객체를 변환할 필요가 없어 오류가 발생하지 않음.

# Ⅶ. 개선 가능 사항
## 텔로 드론의 최소이동거리가 20cm로 주어진 원 크기에 비해 큰 경향이 있음. 따라서 원의 중심을 찾고 중심으로 이동하는 과정에서 정밀한 조정이 어려웠음.

# Ⅷ. Reference
https://kr.mathworks.com/help/images/identifying-round-objects.html

https://kr.mathworks.com/help/images/ref/regionprops.html

https://bkshin.tistory.com/entry/OpenCV-19-%EB%AA%A8%ED%8F%B4%EB%A1%9C%EC%A7%80Morphology-%EC%97%B0%EC%82%B0-%EC%B9%A8%EC%8B%9D-%ED%8C%BD%EC%B0%BD-%EC%97%B4%EB%A6%BC-%EB%8B%AB%ED%9E%98-%EA%B7%B8%EB%A0%88%EB%94%94%EC%96%B8%ED%8A%B8-%ED%83%91%ED%96%87-%EB%B8%94%EB%9E%99%ED%96%87
