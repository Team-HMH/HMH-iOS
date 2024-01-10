# 🚀 하면함
> ### 스마트폰 중독 탈출, 너도 하면함!
#### 디지털 디톡스 서비스 ‘하면함’은
챌린지와 특정 앱 스크린타임 제한 기능을 이용해 건강한 디지털 습관을 형성해주는 서비스입니다.

## 🍎 HMH-iOS Team
![아요햄](https://github.com/Team-HMH/HMH-iOS/assets/68178395/3a51e265-723b-48a1-b91a-baed208f73e4)

| 👑 이지희 | 김선우 | 김보연 |
| :--------: | :--------: | :--------: |
|<img src ="https://github.com/Team-HMH/HMH-iOS/assets/68178395/e606e81f-1630-46b7-9c71-11f57590e9d7" width = "200px"/> | <img src = "https://github.com/Team-HMH/HMH-iOS/assets/68178395/5e4be2af-2d9d-4719-ba2d-055d33ecb5de" width = "200px"/> | <img src="https://github.com/Team-HMH/HMH-iOS/assets/68178395/d0ccdb03-e737-4d51-9999-50c63d155e79" width = "200px"/> |
| [Zoe0929](https://github.com/Zoe0929) | [Seon Woo Kim](https://github.com/kim-seonwoo) | [boyeon](https://github.com/boyeon0119) |


## 💻 프로젝트 기술 스택
### 개발스택 (Development Stack)
<img src="https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=Swift&logoColor=white"/> <img src="https://img.shields.io/badge/UIKit-2396F3?style=flat-square&logo=UIKit&logoColor=white"/> <img src="https://img.shields.io/badge/iOS-000000?style=flat-square&logo=ios&logoColor=white"/>

### Develop Enviroment 
<img src="https://img.shields.io/badge/xcode 15.1-147EFB?style=flat-square&logo=Xcode&logoColor=white"/> <img src="https://img.shields.io/badge/iOS 15.0-000000?style=flat-square&logo=ios&logoColor=white"/>

## 📌 Git Convention
[🚀 git convention 바로가기](https://github.com/Team-HMH/HMH-iOS/wiki/%F0%9F%9A%80-HMH-Git-flow)
### 브랜치 전략
![gitbranch](https://github.com/Team-HMH/HMH-iOS/assets/68178395/bef9ff04-7f4c-4460-adb7-b861b848b6ea)
```swift
main - release 관리 
develop - 머지용
feat - 각자 사용하는 브랜치
```


### 브랜치 네이밍 규칙
`prefix` /`#issueNumber`/ `작업한 view`
#### 폴더링(prefix)
    - `feat` : 기능 구현
    - `network` : 네트워크
    - `fix` : 간단한 수정
    - `set` : 프로젝트 세팅과 같은 기초 세팅
### 커밋 규칙
#### 커밋 메시지
- `[prefix/#issueNumber] discription` 형식으로 작성한다.
#### Prefix
|Prefix|Role|
|:---:|:---:|
|Set| 환경 세팅 |
|Feat| 새로운 기능 구현|
|Add| 파일 추가 |
|Delete| 파일 삭제 |
|Fix| 버그 해결 |
|Chore| 기타 |
#### 규칙
- 마침표, 특수기호는 사용하지 않는다.
- 간결한 설명만 덧붙인다.



## 📁 Foldering
``` 
├── Application
│   ├── Appdelegate
│   ├── SceneDelegate
├── Global
│   ├── Extension
│   ├── Literals
│   │   ├── Literal
│   │   ├── String
│   ├── Protocols
│   ├── Resources
│   │   ├── Font
│   │   ├── Assets
│   │   ├── Info.plist
│   ├── SupportingFiles
│   │   ├── Base
├───├───├───── LaunchScreen
├── Network
│   ├── Base
│   ├── DataModel
│   ├── Service
├── Presentation 
│   ├── Common
│   │   ├── UIComponents 
│   ├── Home
│   │   ├── ViewControllers
│   │   ├── Views
│   │   ├── Models
├───├───├── Cells
```


## 🖥️ HMH Swift Style Guide
[🚀 HMH Swift Style Guide 바로가기](https://github.com/Team-HMH/HMH-iOS/wiki/%F0%9F%9A%80-HMH-Swift-Style-Guide)


## 📚 Library
| 사용 라이브러리 | 설명 | 
| :-------- | :-------- |
| Snapkit | codeBase의 autoLayout을 돕는 라이브러리 |
| Then | codeBase로 UIComponent를 선언할 시 간소화하기 위해 사용 |
| KingFisher | 서버 통신의 이미지를 가져오기 위한 라이브러리 |
| KakaoSDK | (추후) 카카오 소셜 로그인시 사용 |
