# 👑 SpeaKing 👑
AI 기반 영어 말하기 분석 애플리케이션 **👑** **SpeaKing 👑**

🏆 2023-1학기 캡스톤디자인과창업프로젝트B 포스터 세션 **장려상 수상**


<img width="1298" alt="스크린샷 2023-06-08 오후 10 21 43" src="https://github.com/YoungSisters/SpeaKing-iOS/assets/68412683/cb79c48f-3fe2-4f10-a5b7-c20c74538f03">


- [SpeaKing 시연 영상](https://youtube.com/shorts/Xh5Y8_xAgw0?feature=share)
- [SpeaKing 포스터](https://drive.google.com/file/d/1AgLmxcjavzyDC2EIFP09vNXb76ct6Iqt/view?usp=sharing)

## 🎙 프로젝트 소개

<img width="866" alt="스크린샷 2023-06-08 오후 10 12 44" src="https://github.com/YoungSisters/SpeaKing-iOS/assets/68412683/da0340ae-bc4a-407d-a0d2-6c3357da53db">

일상 회화 외에도 토익스피킹과 같은 말하기 시험, 영어 면접, 발표 등 영어 스피킹을 준비해야 할 상황은 점점 늘어나고 있습니다.

하지만 읽기, 쓰기 위주의 영어 공부를 해왔던 대부분의 한국인들에게 혼자 스피킹 연습을 하는 것은 쉬운 일이 아닙니다.

심지어 실제 앱 스토어에 등록되어 있는 대부분의 스피킹 앱들은 일상 회화 표현 학습을 위한 앱이 대부분입니다.

스피킹에서도 영어 글쓰기를 첨삭해주는 Grammarly와 같은 분석 서비스가 있다면 얼마나 좋을까요?

따라서 저희 영시스터즈는 누구나 부담없이 영어 스피킹 실력을 점검할 수 있도록, 스피킹에 꼭 필요한 다양한 분석 결과를 제공하는 AI 기반 영어 말하기 분석 애플리케이션 SpeaKing을 개발하게 되었습니다.


<img width="800" src="https://user-images.githubusercontent.com/68412683/206727129-ffb64038-e4ed-4009-be13-83722bb4c059.png" />

## 🎙 프로젝트 구조

<img width="716" alt="스크린샷 2023-06-08 오후 9 58 08" src="https://github.com/YoungSisters/SpeaKing-iOS/assets/68412683/5a8737e2-b062-463e-9a9b-762b28527350">

- Client: Swift(iOS)
- Server: Node.js, MySQL, AWS S3, EC2
- NLP: Pytorch, Keras, Flask, AWS EC2

## 🎙 팀원 소개

| <img width="200" src="https://user-images.githubusercontent.com/68412683/206727368-df94675f-d152-494c-9535-b99006796519.png"/> | <img width="200" src="https://user-images.githubusercontent.com/68412683/206727359-a653906e-0847-4702-a7e4-4c1ac532bd46.png"/> | <img width="200" src="https://user-images.githubusercontent.com/68412683/206727349-a0454fb5-8b5e-446c-a3ab-c14b19b1c9b9.png"/> |
| --- | --- | --- |
| **이서영** | **이지영** | **이남영** |
| 클라이언트 | 백엔드 | NLP |


## 🎙 클라이언트 사용 기술

- 음성 녹음 및 재생
    - AVFoundation
- STT
    - Apple Speech
- 발음평가
    - ETRI 발음 평가 API
- 기타 라이브러리
    - Alamofire (HTTP 통신)
    - Charts (분석 결과 시각화)
    - Lottie (로딩 화면 애니메이션)
    - Realm (음성 녹음 관련 메타데이터 로컬 저장)
