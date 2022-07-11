# YakDrone
 ### 대한전기학회 주관 미니드론 대회 본선 진출 팀 “약둘기”의 드론 제어 클래스입니다.

# Getting Started
### 아래 코드와 설명은 약둘기 팀이 어떤 알고리즘과 방법론을 적용했는지 이해하기 쉽도록 구성되었습니다.

# Requirements
 ### Image Processing Toolbox, MATLAB Support Package for Ryze Tello Drones

지향점 및 방법론

코드 유지와 보수, 디버그 및 효율적인 작동을 위하여 아래와 같은 지향점을 두었음.

객체지향 프로그래밍으로써 클래스 구조를 설계.
함수형 프로그래밍을 지향하여 여러 멤버함수의 조합으로 설계.
Infinite Loop문을 한개만 두고 멤버변수를 통해 데이터를 저장함으로써 메모리 최적화 및 효율성 극대화.

에러 처리와 비상착륙

불안정한 네트워크 상황 및 일시적인 이미지 캡처 실패로 인한 잘못된 참조로 에러가 발생할 경우 드론이 제자리에서 멈추게 되어 행동불능에 빠지는 경우가 있었음.
이를 모든 함수에 대해 Try catch 예외문으로 처리하여 문제 상황을 디버그 할 수 있었으며 동시에 일시적인 문제에 대하여 드론이 회복할 시간을 줄 수 있음. 


변수 정의
==================
코드 관리를 위하여 변수 앞에 변수타입 태그를 같이 적음
—------------------------------
a로시작하는 변수 : 배열 선언
c로 시작하는 변수 :상수값 선언
n로 시작하는 변수 : numerical 변수 선언
is으로 시작하는 변수 : boolean 선언


##2.2 중요 멤버변수
—------------------
aFiltered_blue=[] → 파랑색을 검출한 배열
aBestCircle=[] → 원형성이 가장 높은 원의 좌표값의 배열
aCentroid=[] →  원형성이 가장 높은 원의 좌표값의 배열의 중심값 (원의 중심)

cMin_blue_th = 0.595
cMax_blue_th = 0.670

nCount → 몇번째 원을 통과 해야하는지를 나타내는  변수 
nStep -> 몇번째 단계인지를 나타내는 변수

3. Flow Diagram (원 하나를 통과할때)   
![Alt text](C:\Users\well8\Desktop\circlefind.png)   
![Alt text](C:\Users\well8\Desktop\center.png)     
![Alt text](C:\Users\well8\Desktop\centerfinder.png)   
![Alt text](C:\Users\well8\Desktop\circlefind.png)   
![Alt text](C:\Users\well8\Desktop\turn.png)   





