# 한밭대학교 컴퓨터공학과 Mobicom팀

**팀 구성**
- 20181625 오명진 
- 20181584 김영우
- 20197130 전수진

## <u>Teamate</u> Project Background
- ### 필요성
  - 배달 오토바이의 돌발 행동(차간 주행, 보도 주행 등)으로 인한 사고를 방지하기 위해 배달 오토바이의 배달함을 활용하여 난폭 운전을 감지한다. 이를 통해 해당 배달 기사의 운전 정보를 수집하고 갱신하여, 배달 플랫폼에서 배달 기사들의 정보를 관리할 수 있도록 한다. 이를 기반으로, 보다 효과적인 대응과 응용을 통해 교통 환경의 안전성을 높이는 것이 프로젝트의 목표이다.
- ### 기존 해결책의 문제점
  - 기술 한계와 인간 요소의 문제로, 자율주행 기술은 작은 이동수단인 배달 오토바이의 특수한 상황과 운전자의 난폭한 운전 행동을 완전히 예방하기 어렵다.
  - 다양한 환경과 법적 문제로, 다양한 돌발 상황과 법적 문제에 대한 대응이 자율주행 기술로 완벽하게 해결되지 않아 안전성과 법적 책임 문제가 남아있다.
  
## System Design
  - ### System Requirements
    - 시스템 구성도
      
      ![image](https://github.com/HBNU-SWUNIV/come-capstone23-mobicom23/assets/102645399/46796017-8553-4489-8f89-56a6bc5e179c)
      
    
## Case Study
  - ### Description

    ![image](https://github.com/HBNU-SWUNIV/come-capstone23-mobicom23/assets/102645399/cc2f563c-6503-47dd-8d02-4ae9f56199f3)
  1. 로그인 화면: 배달 기사는 '회원가입'을 눌러 계정을 추가할 수 있고, 생성된 계정으로 '로그인'을 할 수 있다.
  2. 메인 화면: 'scan'을 눌러 장착된 센서와 연결을 하고 'start'를 눌러 실시간으로 측정된 데이터를 보여준다. 차간 주행 또는 갈지자(之) 주행을 할 때 경고 표시를 준다.
  3. 지도 화면: 사용자의 난폭 운전의 이력을 마커로 표시해 준다. 마커는 난폭 운전의 종류와 발생한 시간을 보여준다. 모든 배달 기사의 난폭 운전 이력을 조회하여 현재 위치를 기준으로 주변에 난폭 운전이 많이 발생되었으면 오른쪽 상단에 경고 표시를 준다.
  4. 설정 화면: 사용자의 이름과 등급이 표시되며 등급은 난폭 운전의 데이터로 측정이 된다. 등급은 '안전', '주의', '경고' 3단계로 표시된다.

  
## Conclusion
  - 배달 오토바이의 난폭 운전 예방 및 안전운전 촉진
  - 배달 플랫폼이 배달 기사의 난폭 운전 정보를 제공
  
## Project Outcome
- ### 2023년도 한국통신학회 추계종합학술발표회 참가
- ### 2023년도 한밭대학교 창의적 종합설계 경진대회 창의상 수상
- ### 제4회 창의혁신 캡스톤디자인 경진대회 참가
- ### 공개 SW 개발자 대회 참가
