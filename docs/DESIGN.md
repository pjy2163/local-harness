# Common Design Direction

프로젝트마다 브랜드와 세부 컴포넌트는 달라질 수 있지만, 별도 지시가 없으면 이 문서를 시각적 기본값으로 사용한다. 목표는 하얀 화면 위에 정보가 조용하고 정확하게 놓이는, 세련되고 가벼운 제품 디자인이다.

## 1. Design character

다음 다섯 단어를 우선한다.

> White · Quiet · Precise · Airy · Functional

- 순백색에 가까운 캔버스와 차가운 회색 계층을 사용한다.
- 장식보다 타이포그래피, 여백, 정렬과 실제 제품 정보를 강조한다.
- 얇은 선, 낮은 elevation, 제한된 포인트 컬러로 깊이를 표현한다.
- 화면은 넉넉하게 호흡하되 컨트롤 자체는 간결하고 효율적으로 만든다.
- 베이지, 크림, 아이보리, 황갈색 등 따뜻한 중성색은 사용하지 않는다.

## 2. Fixed baseline and project overrides

### Common baseline

- 흰색 중심의 light theme
- cool-neutral text, border와 surface
- 넉넉한 글자 간격과 명확한 행간
- 한 화면에 하나의 주된 accent 계열
- hairline border와 매우 약한 shadow
- loading, empty, error, success와 disabled 상태 설계
- 반응형, 키보드 접근성, focus 표시와 명도 대비

### Decide per project

- accent hue와 브랜드 색상
- 로고, 아이콘 스타일과 이미지 방향
- serif/sans 조합과 라이선스 폰트
- 데이터 밀도, navigation 구조와 핵심 컴포넌트
- marketing page와 product UI 사이의 표현 강도
- dark theme 필요 여부

프로젝트 override는 아래 기본값을 무시할 수 있지만, 이유와 검증 방법을 프로젝트 문서에 남긴다.

## 3. Color system

페이지의 대부분은 white와 cool gray로 구성한다. 색은 상태와 행동을 설명할 때만 사용한다.

| Token | Default | Role |
|---|---|---|
| `--canvas` | `#FFFFFF` | 기본 페이지 배경 |
| `--surface` | `#FBFCFD` | 카드와 입력 배경 |
| `--surface-subtle` | `#F6F8FA` | 섹션 구분과 제품 screenshot 받침 |
| `--surface-hover` | `#F1F3F6` | hover와 선택 전 상태 |
| `--text-primary` | `#17181C` | 제목과 핵심 정보 |
| `--text-secondary` | `#454A54` | 본문과 보조 제목 |
| `--text-muted` | `#737985` | 설명, metadata와 placeholder |
| `--border` | `#E6E9EE` | 기본 hairline border |
| `--border-strong` | `#D7DBE2` | 입력·선택 경계 |
| `--accent` | `#5E8FF7` | 프로젝트가 교체할 primary action |
| `--focus` | `#3978F6` | focus ring과 접근성 신호 |
| `--danger` | `#D94A5A` | 오류와 파괴적 행동 |
| `--success` | `#2F8F68` | 성공 상태 |

### Color rules

- white 계열이 한 화면 surface의 80% 이상을 차지하게 한다.
- accent는 primary CTA, active state, link와 focus처럼 기능이 있는 곳에만 쓴다.
- pastel 색을 쓰더라도 채도를 낮춘 cool tint만 보조 정보에 제한한다.
- 따뜻한 paper tone, beige panel, cream card와 brown-gray text를 만들지 않는다.
- 색만으로 상태를 전달하지 않고 icon, text 또는 shape를 함께 사용한다.

## 4. Typography

기본 폰트는 라이선스와 한글 가독성을 우선한다.

```css
font-family: "Pretendard Variable", "Inter Variable", Inter,
  -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
```

PP Neue Montreal 같은 light grotesk가 프로젝트에 정식 제공되면 영문 display에 사용할 수 있다. 제공되지 않은 유료 폰트를 다운로드하거나 대체품인 것처럼 사용하지 않는다.

| Role | Size | Weight | Line height | Letter spacing |
|---|---:|---:|---:|---:|
| Display | `clamp(48px, 7vw, 80px)` | 300 | 1.02–1.08 | `0.005em` |
| H1 | `clamp(40px, 5vw, 64px)` | 300 | 1.08–1.15 | `0.008em` |
| H2 | `clamp(30px, 3.5vw, 44px)` | 300–400 | 1.15–1.25 | `0.01em` |
| H3 | 22–28px | 400 | 1.3 | `0.012em` |
| Body | 16–18px | 400 | 1.6–1.75 | `0.015em` |
| UI text | 14–16px | 400–500 | 1.4–1.55 | `0.02em` |
| Label | 11–13px | 500 | 1.4 | `0.04em` |

- 사용자가 요청한 넉넉한 자간을 유지하되 긴 한글 본문은 `0.02em`을 넘기지 않는다.
- 영문 uppercase micro-label은 최대 `0.08em`까지 허용한다.
- 제목은 가볍게, 컨트롤과 작은 글자는 선명하게 보이도록 weight를 올린다.
- 본문 한 줄은 데스크톱에서 약 55–75자로 제한한다.
- 제목에 음수 letter-spacing을 사용하지 않는다.

## 5. Layout and spacing

- Page max width: `1200–1280px`
- Reading width: `640–720px`
- Page gutter: mobile `20px`, tablet `32px`, desktop `48–64px`
- Section spacing: mobile `64–88px`, desktop `96–144px`
- Card padding: mobile `20px`, desktop `24–32px`
- Component gap: `8 / 12 / 16 / 24 / 32px`
- Major layout gap: `48 / 64 / 96 / 128px`

12-column grid를 기본으로 하되 콘텐츠가 단순하면 억지로 다단 구조를 만들지 않는다. 큰 제목과 설명은 좁은 읽기 폭에 두고, 실제 제품 화면·데이터 표·시각 자료는 더 넓은 컨테이너를 사용한다.

## 6. Surfaces, shape and elevation

- Card radius: `12–18px`
- Button/input radius: `8–10px`
- Small chip radius: `6–8px`; pill은 status/tag에만 사용
- Border: 기본 `1px solid var(--border)`
- Shadow: `0 8px 30px rgba(17, 24, 39, 0.04)` 이하
- 중첩 카드, 두꺼운 border와 큰 drop shadow를 동시에 쓰지 않는다.
- glassmorphism, 강한 gradient와 과도한 blur를 기본 스타일로 사용하지 않는다.

## 7. Component baseline

### Navigation

흰색 또는 투명 surface, 명확한 현재 위치, 낮은 시각적 무게를 사용한다. sticky 여부는 정보 구조가 요구할 때만 선택한다.

### Buttons

- 한 화면에 primary filled action은 가능한 한 하나만 둔다.
- secondary는 outline 또는 ghost로 만든다.
- 최소 높이 40px, 주요 CTA는 44–48px를 사용한다.
- hover, active, focus, disabled와 loading 상태를 모두 만든다.

### Cards and data panels

Zelt처럼 복잡한 제품 정보도 한눈에 읽히도록 title, value, metadata, action 순서를 유지한다. 배경색보다 간격, 정렬과 hairline border로 묶는다. 제품 screenshot은 `16–20px` radius의 차가운 회색 frame 안에 배치할 수 있다.

### Forms

label을 placeholder로 대체하지 않는다. 입력 오류는 필드 가까이에 원인과 해결 방법을 보여준다. focus ring을 제거하지 않는다.

### Icons and imagery

아이콘은 단순한 line 또는 restrained filled style 중 프로젝트에서 하나를 고른다. stock photo와 무관한 장식 이미지를 기본으로 넣지 않는다. 실제 제품 화면, 데이터와 사용 맥락이 우선이다.

## 8. Required UI states

모든 주요 흐름에서 다음 상태를 설계한다.

| State | Minimum requirement |
|---|---|
| Loading | layout shift를 줄이는 skeleton 또는 명확한 progress |
| Empty | 이유, 다음 행동과 필요한 경우 example |
| Error | 사용자 언어의 원인, 복구 행동과 보존된 입력 |
| Success | 완료 결과와 다음 단계 |
| Partial | 일부 데이터 실패와 사용 가능한 결과 구분 |
| Disabled | 비활성 이유를 주변 context에서 이해 가능 |

## 9. Motion

- 기본 duration은 120–220ms, 큰 화면 전환은 최대 320ms다.
- opacity와 작은 transform 중심으로 사용한다.
- 애니메이션은 관계·상태 변화·결과를 설명해야 한다.
- `prefers-reduced-motion`을 존중한다.

## 10. Accessibility and responsive behavior

- 일반 텍스트 WCAG AA contrast를 목표로 한다.
- interactive target은 최소 `40×40px`, 모바일 주요 target은 `44×44px`를 권장한다.
- keyboard tab 순서, visible focus, semantic heading과 form label을 확인한다.
- 320px 폭에서 가로 overflow 없이 핵심 흐름이 작동해야 한다.
- desktop 축소판이 아니라 모바일에서 정보 우선순위를 다시 정한다.
- color, hover와 motion만으로 의미를 전달하지 않는다.

## 11. Avoid

- beige, ivory, cream, tan과 warm paper background
- 큰 문단의 centered alignment
- 모든 요소를 card로 감싸는 layout
- bold heading과 강한 shadow를 동시에 사용
- 장식용 gradient, floating orb와 이유 없는 blur
- 의미 없는 dashboard metric과 placeholder chart
- 한 화면에 여러 primary CTA
- 지나치게 좁은 자간 또는 긴 본문의 과도한 tracking

## 12. Project override template

프로젝트를 시작할 때 필요한 항목만 채운다.

```text
Project personality:
Primary user and context:
Accent color:
Typography override:
Density: comfortable | compact
Core screens/components:
Imagery/icon direction:
Accessibility constraints:
Intentional deviations from common baseline:
Visual verification method:
```

## 13. Visual review checklist

- [ ] 첫 화면에서 primary action과 정보 hierarchy가 분명하다.
- [ ] 화면 대부분이 pure white 또는 cool near-white다.
- [ ] beige나 따뜻한 중성색이 섞이지 않았다.
- [ ] 제목·본문·label의 자간과 행간이 각각 읽기 좋다.
- [ ] accent는 기능적인 위치에 제한됐다.
- [ ] border와 shadow가 콘텐츠보다 먼저 보이지 않는다.
- [ ] loading, empty, error, success와 disabled 상태가 있다.
- [ ] keyboard, focus, contrast와 모바일 흐름을 확인했다.
- [ ] 프로젝트별 override와 그 이유가 기록됐다.
- [ ] screenshot 또는 브라우저 확인으로 실제 렌더링을 검증했다.

## References and provenance

- [Zelt](https://zelt.app/): 복잡한 제품 범위를 단순하고 직관적인 정보 구조로 제시하는 방향을 참고한다.
- [Aqua Voice on Refero](https://styles.refero.design/style/6734fe92-6a02-45d5-8d72-0c55b37ace82): near-white canvas, ultra-light typography, cool gray ladder, 단일 기능 accent, hairline border와 낮은 elevation을 참고한다.
