![Frame 1](https://github.com/Team-HMH/HMH-iOS/assets/68178395/0d8863be-0dbe-4251-a732-67b7a0f79afa)
# 🚀 하면함
![Instagram post - 14](https://github.com/Team-HMH/HMH-iOS/assets/68178395/95948669-7b32-4a16-9840-602a8b30f10d)
[하면함 노션보러 가기🔭](https://msmmx.notion.site/HMH-iOS-2-0ad81039d0c04d4981f26865cecf7f40?pvs=4)
> ### 스마트폰 중독 탈출, 너도 하면함!
#### 디지털 디톡스 서비스 ‘하면함’은
챌린지와 특정 앱 스크린타임 제한 기능을 이용해 건강한 디지털 습관을 형성해주는 서비스입니다.

## 🍎 HMH-iOS Team
| 👑 이지희 | 김선우 | 김보연 |
| :--------: | :--------: | :--------: |
|<img src ="https://github.com/Team-HMH/HMH-iOS/assets/68178395/02238ee4-ca94-498c-90c7-a3c1e81d1d5b" width = "200px"/> | <img src = "https://github.com/Team-HMH/HMH-iOS/assets/68178395/98fd130d-23d1-409f-8709-e76d22ff7712" width = "200px"/> | <img src="https://github.com/Team-HMH/HMH-iOS/assets/68178395/a001eade-2e3e-45b6-80eb-c7be3ebafc98" width = "200px"/> |
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
│   ├── Foundation
│   ├── Router
│   ├── DTO
│   |     ├── SceneModel
│   ├── Service
├── Presentation 
│   ├── Common
│   │   ├── UIComponents 
│   ├── Home
│   │   ├── ViewControllers
│   │   ├── Views
│   │   ├── Models
├───├───├── Cells"
|
extension - DeviceMonitor, DeviceReport, ShieldAction, ShieldConfig
```


## 🖥️ HMH Swift Style Guide
[🚀 HMH Swift Style Guide 바로가기](https://github.com/Team-HMH/HMH-iOS/wiki/%F0%9F%9A%80-HMH-Swift-Style-Guide)

## 시스템 구성
![Slide 16_9 - 6](https://github.com/Team-HMH/HMH-iOS/assets/68178395/975d1008-df0d-4e40-a6fd-1e3782ded527)



## 📚 Library
| 사용 라이브러리 | 설명 | 
| :-------- | :-------- |
| Snapkit | codeBase의 autoLayout을 돕는 라이브러리 |
| Then | codeBase로 UIComponent를 선언할 시 간소화하기 위해 사용 |
| KingFisher | 서버 통신의 이미지를 가져오기 위한 라이브러리 |
| Moya | 서버 통신, 네트워크 계층을 위한 라이브러리 |

