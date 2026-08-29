# Design Boundary (Common Stub)

이 파일은 common branch의 경로 호환성을 위한 stub이다. 공통 하네스는 특정 색상, 폰트, density, component library, landing narrative 또는 브랜드 asset을 강제하지 않는다.

## When a project needs UI

`web` branch의 full `docs/DESIGN.md`를 선택하고 프로젝트별 override를 실제 요구사항으로 작성한다. 구현 전에 핵심 화면과 loading, empty, error, success, partial, disabled 상태 및 반응형 범위를 정한다.

구현 후에는 실제 browser 또는 screenshot으로 hierarchy, spacing, responsive behavior, keyboard flow와 accessibility를 확인한다. 확인되지 않은 visual claim과 유료/외부 asset은 사용하지 않는다.

## Ownership

- common: 사용자 흐름, API/data contract와 상태 표현에 필요한 최소 문서만 소유한다.
- web: visual direction, component guidance, landing/browser verification과 project override를 소유한다.
- 제품: 실제 copy, 기능, asset 권한과 사용자 수용을 소유한다.

`web` overlay가 없거나 UI가 범위 밖이면 이 문서는 추가 작업을 요구하지 않는다.
