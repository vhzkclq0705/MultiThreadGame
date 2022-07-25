# MultiThreadGame
## 케이스 스터디 4주차 과제(MultuThread를 이용한 게임 만들기)
- Thread에 관한 이해 필요
- Swift에서 Thread를 다루는 DispatchQueue 이용하기
- DispatchQueue.global(qos: ).async과 DispatchQueue.main.async를 언제 활용하는지 이해

## 실행 화면

https://user-images.githubusercontent.com/75382687/180732264-b0a59ee1-8a16-4942-834c-42cd5f116d6b.MP4

https://user-images.githubusercontent.com/75382687/180732283-297b5cb9-1506-423c-82d3-bda8f8fcc342.MP4

https://user-images.githubusercontent.com/75382687/180732289-fb5ca691-06dd-4c05-b074-463f9a3bc8f2.MP4

https://user-images.githubusercontent.com/75382687/180732305-e0ce8e90-f269-4357-91fd-c015c4ced4a6.MP4

|ranking|
|---|
|![ranking](https://user-images.githubusercontent.com/75382687/180732622-c377e72a-2cca-4d01-8982-9024dfb51708.PNG)|

<br>

## 새로 알게된 점

- 비동기를 활용한 MultiThreading
  - DispatchQueue.global(qos: .userInteractive).async을 통해 비동기로 다양한 함수를 실행시킬 수 있다.
  - 반목문의 경우, usleep()을 통해 시간 간격을 주어야 한다.

<br>

## 느낀 점

- 라이브러리 없이 게임을 만들기가 쉽지 않았지만 재미있었다.
- Swift에서 Thread 활용에 대해 더 깊게 알게 된 것 같다.
- 탄막의 생성 간격을 많이 줄이면, 일정 이상을 초과한 탄막은 이동을 하지 않는다. subView의 수나 threading 수 제한이 있는 것 같다.
