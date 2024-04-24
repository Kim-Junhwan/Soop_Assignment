# 김준환_iOS 숲 채용 과제

프로젝트 구동 영상 링크: https://vod.afreecatv.com/player/122861243

## 개발 환경
|목적|기술 스택|
|------|---|
|최소 버전|17.3|
|UI 구현|UIKit(코드베이스)|

## 사용 라이브러리

|사용 목적|라이브러리|
|------|---|
|비동기 처리|RxSwift|
|UI|SnapKit|

## 프로젝트 아키텍처 
- MVVM + Clean Architecture
  
![제목 없는 다이어그램 drawio (3)](https://github.com/Kim-Junhwan/Soop_Assignment/assets/58679737/0e0d4992-6c4d-4bf2-9fb8-169643c8747b)

Domain계층, Presentation계층, Data계층으로 나누어서 각 계층을 독립적으로 개발을 할 수 있도록 아키텍처를 구성했습니다. 

## 고민했던 점 
Cancellable 프로토콜을 이용한 Domain계층에서의 Task cancel 처리
- Domain계층의 Usecase에서 Repository로부터 받은 데이터를 Single을 생성하는데, 이때 Dispose.create에 Task를 취소 할 수 있었어야 했습니다.
- Domain계층은 직접적인 프레임 워크에 의존하지 않는 비즈니스 로직을 담당하는 계층이여서 URLSessionTask같은 상세한 타입을 두고 싶지 않았습니다.
- 그래서 Cancellable이라는 프로토콜을 만들어서 URLSessionTask에 이를 채택하는 방식으로 문제를 해결했습니다.

## 회고
시간이 굉장히 촉박해서 기능을 구현하는데 급급했습니다. 이전에 비슷한 문제를 경험을 해서 이렇게 하면 되겠지하고 접근했는데, 생각을 해야하는게 많아서 시간을 많이 소모했습니다. 
