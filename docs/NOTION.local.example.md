# Notion Local Connection Example

이 파일은 선택적 수동 `local → Notion` mirror의 공개 예시다. 실제 연결이 필요할 때 `docs/NOTION.local.md`로 복사하고 사람이 확인한 값만 기록한다. `docs/NOTION.local.md`는 Git에서 제외되며 OAuth token, API secret, 개인 workspace 정보는 저장하지 않는다.

## Connection

| Setting | Value |
|---|---|
| Connection | `NOT_CONNECTED` |
| Source of Truth | local Markdown |
| Sync direction | manual `local → Notion` only |
| Parent page ID | `NOT_CONFIGURED` |
| Requirements database/data source ID | `NOT_CONFIGURED` |
| Decisions database/data source ID | `NOT_CONFIGURED` |
| Work Log database/data source ID | `NOT_CONFIGURED` |
| Troubleshooting database/data source ID | `NOT_CONFIGURED` |
| Last sync | `없음` |

실제 ID와 property 이름은 Notion에서 read-back한 뒤에만 local file에 기록한다. 예시의 placeholder를 실제 값으로 간주하지 않는다.

## Stable keys and property examples

| Local record | Stable key | Minimum property examples |
|---|---|---|
| Requirement | `Requirement ID` (`R-###`) | Requirement ID, Title, Status, Priority, Source, Last updated |
| Decision | `Decision ID` (`ADR-###`) | Decision ID, Title, Status, Area, Impact, Date, Source |
| Work Log | `Local Entry ID` | Local Entry ID, Title, Status, Date, Requirement ID, Verification |
| Troubleshooting | `Incident ID` | Incident ID, Symptom, Root cause, Fix, Status, Date |
| Additional learning | `Learning ID` (`LRN-###`) | Learning ID, Title, Principle, Applied to, Source, Date |

Property names and option values are examples only until the real target schema is fetched and compared. Do not create a database merely because an example row exists.

## Manual sync procedure

1. Confirm the target parent/database IDs and access scope with the human owner.
2. Fetch the target schema and compare property names, types and status options with this local contract.
3. Query each stable key before writing. Mark collisions or mismatched records as `PARTIAL`/`FAILED` and stop the affected write.
4. Show the planned create/update count and page targets. Obtain approval for the external write.
5. Upsert only the approved records and preserve the local body as canonical.
6. Read back the created/updated records and compare stable key, properties and body summary.
7. Record planned count, actual count, conflicts, read-back result and status in the ignored local sync log.

No automatic schedule, bidirectional import, deletion propagation or Source of Truth change is allowed by this template. If no target is configured, record `NOT_CONNECTED` and continue with local closure.

## Sync log

| Time | Direction | Target | Planned | Actual | Conflicts | Read-back | Status |
|---|---|---|---:|---:|---|---|---|
| - | - | - | 0 | 0 | - | - | `NOT_CONNECTED` |
