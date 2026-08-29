# Landing Boundary (Common Stub)

이 파일은 common branch의 경로 호환성을 위한 stub이다. common 하네스는 landing page의 정보 구조, visual style, CTA, 고객 로고, 지표나 운영 약속을 정의하지 않는다.

## Web overlay

랜딩을 만드는 프로젝트는 `web` branch의 full `docs/LANDING.md`를 선택하고 다음 내용을 실제 증거로 초기화한다.

- audience와 검증된 가치 제안
- 실제로 작동하는 사용자 흐름과 capability 상태(`REAL | MIXED | MOCK | PLANNED`)
- evidence와 지원/비지원 운영 경계
- 자동화와 사람 책임, 데이터 출처·신선도·보관
- 실패·부분 실패, privacy/support와 CTA의 loading/error/success 상태

mock·planned·미검증 기능을 delivered claim으로 표현하지 않는다. 구현 후 desktop/mobile, keyboard와 reduced-motion 범위를 실제 browser 또는 screenshot으로 확인한다.

랜딩이 요청되지 않은 프로젝트는 이 stub을 초기화하거나 구현할 필요가 없다.
