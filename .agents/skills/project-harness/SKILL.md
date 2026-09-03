---
name: project-harness
description: 프로젝트 하네스 지침·설정과 eval을 점검하거나 갱신할 때만 사용한다. 일반 기능 구현·디버깅·제품 검증에는 사용하지 않는다.
---

# Harness maintenance

이 스킬은 하네스 자체의 유지보수에만 적용한다. 일반 제품 개발은 루트 `AGENTS.md`와 관련 작업 스킬이
관할한다. TIEAT 등 특정 제품의 도메인·운영 정책을 재사용 템플릿에 복사하지 않는다.

## Small contract

루트 `AGENTS.md`를 읽고 목표·비목표·검수 기준·변경하지 않을 범위를 짧게 정한다.
기본 실행자는 한 명이며, 추가 agent·planner·reviewer는 자동으로 호출하지 않는다.
모델 설정은 요청 범위일 때만 바꾸며 Luna 기본 추론은 `max`를 유지한다.

## Relevant context and edit

- 요청된 harness 파일과 호출부만 읽는다. 일반 `docs/**`와 제품 코드는 이번 유지보수에 필요한 경우만 읽는다.
- skill 범위가 바뀌면 `SKILL.md`, `agents/openai.yaml`과 실제 호출 예시를 함께 맞춘다.
- 기존 사용자 변경·권한·외부 write·HIGH risk gate를 보존하고 최소 delta를 `apply_patch`로 수정한다.
- 문서·Notion closure를 자동 실행하지 않는다. 요청된 지속성 있는 결정은 canonical record 하나로 남길 수 있다.
- 기존 이력을 일괄 정리하거나 새 프레임워크·모델 fallback·승인 게이트를 추가하지 않는다.

## Verify changed behavior

front matter/YAML·TOML 문법, 관련 role-contract 검사와 whitespace/diff를 확인한다.
정적 검사는 설정 정합성 증거이지 모델 행동·성능 증거가 아니다.

작업 routing, 종료 조건 또는 권한 경계를 바꾼 경우만 [경량 eval](../../../docs/EVALS.md)의 관련 사례를
격리된 임시 프로젝트에서 실행한다. 변경된 주요 경로 하나와 필요한 핵심 실패 경로 하나로 제한한다.
실행 agent에는 사용자 요청과 fixture만 전달하고 기대 정답은 보여주지 않는다. 결과 diff·실행 기록을
미리 정한 기준과 비교하며, 단순 문구 검색을 행동 PASS로 대신하지 않는다.
실행 수단·요청 모델·권한이 없으면 해당 eval은 `NOT_RUN`이며 임의 fallback하지 않는다.

제품 변경이 없는 유지보수에는 제품 테스트·전체 회귀를 실행하지 않는다.
결과는 `Claim / Evidence / Not proven`과 정확히 변경한 파일로 보고한다.
커밋·push와 외부 sync는 사용자 요청 없이는 하지 않는다.
