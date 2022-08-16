## 온라인 반찬앱 - SwiftUI

## 구현화면.
![Simulator Screen Recording - iPhone 13 - 2022-08-16 at 17 04 30](https://user-images.githubusercontent.com/62687919/184829474-2d8cd468-8a05-4eed-9f28-e9906a81e285.gif)

## 고민과 해결
### Combine
1. 서버에서 데이터를 받아오는 과정 중 실행이 안되는 문제 발생. 
- subscribe으로 백그라운드 큐에 작업을 지정하고, receive로 메인 큐에서 값을 업데이트함을 명시해줘야 함.

2. 상세화면에서 수량을 늘려 가격, 수량의 텍스트를 변경할 시 이미지들이 사라지는 문제 발생.
- @StateObject를 사용하여, 새로고침 되는 변수들과 관계없이 ThumbViewModel 독립적인 값을 사용하도록 함.

## 학습 내용
1. assign 활용하면 @Published변수에 바로 값을 넣어줄 수 있음.
- 대신 replaceError함수로 에러가 발생했을 때 대체할 값을 미리 넣어주어야 함.

2. sink를 활용하면 에러처리까지 할 수 있음. 
- 모든 비동기 클로져를 처리할 때와 같이 순환참조 방지를 위해 [weak self]를 사용해야 함.
