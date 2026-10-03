---
title: Untitled
date: 2026-09-30
tags:
---
# SPIMS Project: Detailed Implementation Checklist

Parag, based on the problems identified in your research paper, I recommend improving your existing SPIMS (Real-Time Patrol Management and Geospatial Incident Dispatch with Auditable Accountability) project in stages rather than rebuilding it from scratch.

The objective is to make the implementation more reliable, secure, testable, and consistent with what your paper claims.

I'll divide the work into essential fixes, important new features, testing, and optional advanced improvements. The items below are recommendations based on the issues identified in the paper; the exact code changes will depend on what is already implemented in your repository.

## 1. Patrol checkpoint validation and lifecycle

Priority P0 — Essential

Your patrol system needs strict rules governing how a patrol progresses from starting a shift to completing all checkpoints.

![Guard Patrolling System | MLAI Solution - video Dailymotion](https://images.openai.com/static-rsc-4/QjTtLIGcI7uWbJIsblIpHmSxaqKNHIkmyL9kKAE70j-pc3Kb5cjnrqslhDTDKj7bvPkhPdABTBs3WFKsPY8RYunY1bX24z72cfIebcnV8G0GsnIfkl9sbAmTGDQTk9OMUh7Ez9SQm0vL5xcKRwUwuWDRlqwqmyIYLsPRMo4cg1aoa9ARDaelVvlI12hiGS11?purpose=fullsize)

### What you should add

A. Explicit checkpoint states

Every checkpoint should have a defined state:

- `pending` — not yet visited.
    
- `verified` — visit successfully validated.
    
- `skipped` — intentionally skipped with a reason and authorized approval, if required.
    

A checkpoint must not be completed merely because the frontend sends a request saying it is complete.

B. Strict patrol completion rules

When a guard attempts to finish a patrol:

1. Confirm the shift exists.
    
2. Confirm the authenticated guard owns that shift.
    
3. Confirm the shift is currently in progress.
    
4. Check every checkpoint belonging to the shift.
    
5. Reject completion if any checkpoint remains `pending`.
    
6. Confirm that skipped checkpoints satisfy the project's skip policy.
    
7. Atomically mark the shift completed and record the completion timestamp.
    

C. Server-side state transitions

Enforce allowed transitions on the backend, not only in React.

|Current state|Requested transition|Expected result|
|---|---|---|
|Pending|Verified|Allow after validation|
|Pending|Skipped|Allow with required reason/approval|
|Verified|Verified again|Idempotent response or reject|
|Completed shift|Update checkpoint|Reject|
|Unassigned guard|Update another guard's checkpoint|Reject|

### Acceptance criteria

- A patrol with an unfinished checkpoint cannot be completed.
    
- A completed shift cannot be modified through ordinary patrol APIs.
    
- Only the assigned guard or an authorized supervisor can make permitted changes.
    
- Two simultaneous requests cannot cause conflicting patrol states.
    

## 2. GPS validation and checkpoint verification

Priority P0 — Essential

The paper describes GPS-based checkpoint updates. A GPS coordinate submitted by a client does not, by itself, prove that the guard physically visited a location. Your system should validate the available location data and document the limitations.

### What you should add

A. Checkpoint geofencing

Store the expected coordinates and permitted radius for each checkpoint.

For example:

- Checkpoint coordinates: latitude and longitude.
    
- Permitted radius: configurable, such as 50 metres.
    
- Submitted coordinates: latitude and longitude from the guard's device.
    
- Reported GPS accuracy: in metres, when available.
    
- Server receipt timestamp.
    

Use the Haversine formula to calculate the distance between the checkpoint and the reported location.

\[ d=2R\arcsin\left(\sqrt{ \sin^2\frac{\Delta\phi}{2} +\cos\phi_1\cos\phi_2\sin^2\frac{\Delta\lambda}{2} }\right) \]

Here, \(R\) is the Earth's radius, and the angles represent the checkpoint and reported coordinates.

B. Reject suspicious location submissions

Add configurable validation rules for:

- Coordinates outside valid latitude/longitude ranges.
    
- Missing or unreasonably poor reported GPS accuracy.
    
- Locations outside the permitted checkpoint radius.
    
- Old location timestamps.
    
- Duplicate checkpoint submissions.
    
- Location timestamps inconsistent with the patrol sequence.
    
- Excessively old or stale live-location updates.
    

Use server-side timestamps for recording when the server received a submission. Client timestamps should be treated as untrusted input.

C. Prevent simple replay attacks

Give each location submission a unique request or event ID. Record processed IDs and prevent the same event from being accepted repeatedly.

Do not assume that a unique ID alone proves the location is genuine. GPS spoofing is still possible.

D. Consider additional verification

For higher-assurance patrols, you could support QR-code scanning or NFC tags at checkpoints. These provide an additional signal that a guard interacted with a checkpoint, though neither method alone guarantees physical presence.

### Suggested data fields

|Field|Purpose|
|---|---|
|`checkpointId`|Identifies the checkpoint|
|`latitude`, `longitude`|Reported position|
|`accuracyMeters`|Reported GPS accuracy|
|`serverReceivedAt`|Trusted server receipt time|
|`clientCapturedAt`|Device-reported capture time|
|`distanceMeters`|Calculated distance from checkpoint|
|`verificationStatus`|Accepted, rejected, or pending review|
|`rejectionReason`|Explains failed validation|

### Acceptance criteria

- A location outside the permitted radius cannot automatically verify a checkpoint.
    
- Duplicate submissions do not create duplicate verification events.
    
- Rejected submissions are logged with a reason.
    
- The paper describes this as GPS-based validation, not proof against all location spoofing.
    

## 3. Incident dispatch and actual guard assignment

Priority P0 — Essential

One important distinction in your paper is the difference between notifying nearby guards and assigning an incident to a specific guard. If your current algorithm only sends notifications to guards inside a radius, the system should not claim that it automatically assigns the incident.

![Security Guard Management Software for Southern Africa | MyProtektor](https://images.openai.com/static-rsc-4/9OyfUBLuTs984CgYJvhX3BJb2gDf8nf--guPGMcwOG2f1FCDRloRqDl01W4aOfxje66HnWm8FyE0_DIhozrqlGW3Y1H58Srh9e98TxITg9LGcS_U844jzzy186_XvonB2p6HozwiRiq34lQljciFTk9Fxl03lesZy239Xai1UekgvC4Eq2ZBhQaIO3SOucoI?purpose=fullsize)

### What you should add

A. Guard eligibility filtering

Before selecting a guard, check:

- Guard is authenticated and active.
    
- Guard is on duty.
    
- Guard is not offline.
    
- Guard's latest location is sufficiently recent.
    
- Guard is not already handling an incompatible incident.
    
- Guard is authorized for the incident's site or zone.
    
- Guard is within the configured dispatch radius.
    

A guard being online should not automatically make them eligible for every incident.

B. Guard selection

If you want genuine automatic dispatch, implement a selection strategy. For example, select the eligible guard with the shortest estimated distance, subject to assignment rules.

A basic selection flow:

#chatgpt-mermaid-_r_1ld_{font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;font-size:14px;fill:rgb(255, 255, 255);}@keyframes edge-animation-frame{from{stroke-dashoffset:0;}}@keyframes dash{to{stroke-dashoffset:0;}}#chatgpt-mermaid-_r_1ld_ .edge-animation-slow{stroke-dasharray:9,5!important;stroke-dashoffset:900;animation:dash 50s linear infinite;stroke-linecap:round;}#chatgpt-mermaid-_r_1ld_ .edge-animation-fast{stroke-dasharray:9,5!important;stroke-dashoffset:900;animation:dash 20s linear infinite;stroke-linecap:round;}#chatgpt-mermaid-_r_1ld_ .error-icon{fill:rgba(54, 54, 54, 0.96);}#chatgpt-mermaid-_r_1ld_ .error-text{fill:rgb(255, 255, 255);stroke:rgb(255, 255, 255);}#chatgpt-mermaid-_r_1ld_ .edge-thickness-normal{stroke-width:1px;}#chatgpt-mermaid-_r_1ld_ .edge-thickness-thick{stroke-width:3.5px;}#chatgpt-mermaid-_r_1ld_ .edge-pattern-solid{stroke-dasharray:0;}#chatgpt-mermaid-_r_1ld_ .edge-thickness-invisible{stroke-width:0;fill:none;}#chatgpt-mermaid-_r_1ld_ .edge-pattern-dashed{stroke-dasharray:3;}#chatgpt-mermaid-_r_1ld_ .edge-pattern-dotted{stroke-dasharray:2;}#chatgpt-mermaid-_r_1ld_ .marker{fill:rgba(255, 255, 255, 0.498);stroke:rgba(255, 255, 255, 0.498);}#chatgpt-mermaid-_r_1ld_ .marker.cross{stroke:rgba(255, 255, 255, 0.498);}#chatgpt-mermaid-_r_1ld_ svg{font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;font-size:14px;}#chatgpt-mermaid-_r_1ld_ p{margin:0;}#chatgpt-mermaid-_r_1ld_ .label{font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;color:rgb(255, 255, 255);}#chatgpt-mermaid-_r_1ld_ .cluster-label text{fill:rgb(255, 255, 255);}#chatgpt-mermaid-_r_1ld_ .cluster-label span{color:rgb(255, 255, 255);}#chatgpt-mermaid-_r_1ld_ .cluster-label span p{background-color:transparent;}#chatgpt-mermaid-_r_1ld_ .label text,#chatgpt-mermaid-_r_1ld_ span{fill:rgb(255, 255, 255);color:rgb(255, 255, 255);}#chatgpt-mermaid-_r_1ld_ .node rect,#chatgpt-mermaid-_r_1ld_ .node circle,#chatgpt-mermaid-_r_1ld_ .node ellipse,#chatgpt-mermaid-_r_1ld_ .node polygon,#chatgpt-mermaid-_r_1ld_ .node path{fill:rgb(68, 41, 53);stroke:rgb(171, 79, 122);stroke-width:1px;}#chatgpt-mermaid-_r_1ld_ .rough-node .label text,#chatgpt-mermaid-_r_1ld_ .node .label text,#chatgpt-mermaid-_r_1ld_ .image-shape .label,#chatgpt-mermaid-_r_1ld_ .icon-shape .label{text-anchor:middle;}#chatgpt-mermaid-_r_1ld_ .node .katex path{fill:#000;stroke:#000;stroke-width:1px;}#chatgpt-mermaid-_r_1ld_ .rough-node .label,#chatgpt-mermaid-_r_1ld_ .node .label,#chatgpt-mermaid-_r_1ld_ .image-shape .label,#chatgpt-mermaid-_r_1ld_ .icon-shape .label{text-align:center;}#chatgpt-mermaid-_r_1ld_ .node.clickable{cursor:pointer;}#chatgpt-mermaid-_r_1ld_ .root .anchor path{fill:rgba(255, 255, 255, 0.498)!important;stroke-width:0;stroke:rgba(255, 255, 255, 0.498);}#chatgpt-mermaid-_r_1ld_ .arrowheadPath{fill:rgba(255, 255, 255, 0.498);}#chatgpt-mermaid-_r_1ld_ .edgePath .path{stroke:rgba(255, 255, 255, 0.498);stroke-width:1px;}#chatgpt-mermaid-_r_1ld_ .flowchart-link{stroke:rgba(255, 255, 255, 0.498);fill:none;}#chatgpt-mermaid-_r_1ld_ .edgeLabel{background-color:rgb(24, 24, 24);text-align:center;}#chatgpt-mermaid-_r_1ld_ .edgeLabel p{background-color:rgb(24, 24, 24);}#chatgpt-mermaid-_r_1ld_ .edgeLabel rect{opacity:0.5;background-color:rgb(24, 24, 24);fill:rgb(24, 24, 24);}#chatgpt-mermaid-_r_1ld_ .labelBkg{background-color:rgba(24, 24, 24, 0.5);}#chatgpt-mermaid-_r_1ld_ .cluster rect{fill:rgba(54, 54, 54, 0.96);stroke:rgba(255, 255, 255, 0.082);stroke-width:1px;}#chatgpt-mermaid-_r_1ld_ .cluster text{fill:rgb(255, 255, 255);}#chatgpt-mermaid-_r_1ld_ .cluster span{color:rgb(255, 255, 255);}#chatgpt-mermaid-_r_1ld_ div.mermaidTooltip{position:absolute;text-align:center;max-width:200px;padding:2px;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;font-size:12px;background:rgba(54, 54, 54, 0.96);border:1px solid rgba(255, 255, 255, 0.082);border-radius:2px;pointer-events:none;z-index:100;}#chatgpt-mermaid-_r_1ld_ .flowchartTitleText{text-anchor:middle;font-size:18px;fill:rgb(255, 255, 255);}#chatgpt-mermaid-_r_1ld_ rect.text{fill:none;stroke-width:0;}#chatgpt-mermaid-_r_1ld_ .icon-shape,#chatgpt-mermaid-_r_1ld_ .image-shape{background-color:rgb(24, 24, 24);text-align:center;}#chatgpt-mermaid-_r_1ld_ .icon-shape p,#chatgpt-mermaid-_r_1ld_ .image-shape p{background-color:rgb(24, 24, 24);padding:2px;}#chatgpt-mermaid-_r_1ld_ .icon-shape .label rect,#chatgpt-mermaid-_r_1ld_ .image-shape .label rect{opacity:0.5;background-color:rgb(24, 24, 24);fill:rgb(24, 24, 24);}#chatgpt-mermaid-_r_1ld_ .label-icon{display:inline-block;height:1em;overflow:visible;vertical-align:-0.125em;}#chatgpt-mermaid-_r_1ld_ .node .label-icon path{fill:currentColor;stroke:revert;stroke-width:revert;}#chatgpt-mermaid-_r_1ld_ .node .neo-node{stroke:rgb(171, 79, 122);}#chatgpt-mermaid-_r_1ld_ [data-look="neo"].node rect,#chatgpt-mermaid-_r_1ld_ [data-look="neo"].cluster rect,#chatgpt-mermaid-_r_1ld_ [data-look="neo"].node polygon{stroke:url(#chatgpt-mermaid-_r_1ld_-gradient);filter:drop-shadow( 1px 2px 2px rgba(185,185,185,1));}#chatgpt-mermaid-_r_1ld_ [data-look="neo"].swimlane.cluster rect{filter:none;}#chatgpt-mermaid-_r_1ld_ [data-look="neo"].node path{stroke:url(#chatgpt-mermaid-_r_1ld_-gradient);stroke-width:1px;}#chatgpt-mermaid-_r_1ld_ [data-look="neo"].node .outer-path{filter:drop-shadow( 1px 2px 2px rgba(185,185,185,1));}#chatgpt-mermaid-_r_1ld_ [data-look="neo"].node .neo-line path{stroke:rgb(171, 79, 122);filter:none;}#chatgpt-mermaid-_r_1ld_ [data-look="neo"].node circle{stroke:url(#chatgpt-mermaid-_r_1ld_-gradient);filter:drop-shadow( 1px 2px 2px rgba(185,185,185,1));}#chatgpt-mermaid-_r_1ld_ [data-look="neo"].node circle .state-start{fill:#000000;}#chatgpt-mermaid-_r_1ld_ [data-look="neo"].icon-shape .icon{fill:url(#chatgpt-mermaid-_r_1ld_-gradient);filter:drop-shadow( 1px 2px 2px rgba(185,185,185,1));}#chatgpt-mermaid-_r_1ld_ [data-look="neo"].icon-shape .icon-neo path{stroke:url(#chatgpt-mermaid-_r_1ld_-gradient);filter:drop-shadow( 1px 2px 2px rgba(185,185,185,1));}#chatgpt-mermaid-_r_1ld_ .node text{font-size:14px;font-weight:600;letter-spacing:normal;fill:rgb(255, 186, 218);}#chatgpt-mermaid-_r_1ld_ .edgeLabels text{font-size:13px;font-weight:600;letter-spacing:-0.08px;fill:rgb(255, 186, 218);}#chatgpt-mermaid-_r_1ld_ .node tspan[font-weight="normal"],#chatgpt-mermaid-_r_1ld_ .edgeLabels tspan[font-weight="normal"]{font-weight:600;}#chatgpt-mermaid-_r_1ld_ .edgeLabel .label rect{opacity:1;rx:13px;ry:13px;fill:rgb(41, 16, 28);stroke:rgb(95, 53, 72);stroke-width:1px;}#chatgpt-mermaid-_r_1ld_ .node rect,#chatgpt-mermaid-_r_1ld_ .node circle,#chatgpt-mermaid-_r_1ld_ .node ellipse,#chatgpt-mermaid-_r_1ld_ .node polygon,#chatgpt-mermaid-_r_1ld_ .node path{fill:rgb(77, 31, 52);stroke:rgba(255, 255, 255, 0.1);stroke-width:1px;}#chatgpt-mermaid-_r_1ld_ .node rect{rx:16px;ry:16px;}#chatgpt-mermaid-_r_1ld_ .node.mermaid-decision .label-container{fill:rgb(41, 16, 28);stroke:rgb(95, 53, 72);stroke-dasharray:2,2;}#chatgpt-mermaid-_r_1ld_ .edgePaths .flowchart-link{stroke:rgba(255, 255, 255, 0.498);stroke-width:1px;stroke-linecap:round;stroke-linejoin:round;}#chatgpt-mermaid-_r_1ld_ .marker{fill:rgba(255, 255, 255, 0.498);stroke:rgba(255, 255, 255, 0.498);}#chatgpt-mermaid-_r_1ld_ :root{--mermaid-font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;}Incident CreatedFetch Active GuardsFilter by Site, Duty andAvailabilityRemove Stale LocationsCalculate DistanceEligible Guard Found?Mark Unassigned and AlertSupervisorSelect GuardAtomically ReserveAssignmentNotify Selected GuardAccepted in Time?Mark AcceptedExpire Offer and ReassignNoYesYesNo

C. Incident assignment states

Implement a clearly defined lifecycle such as:

- `open`
    
- `offered`
    
- `assigned`
    
- `accepted`
    
- `en_route`
    
- `resolved`
    
- `cancelled`
    

You may need additional states such as `unassigned` or `rejected`, depending on the workflow.

Define which transitions are permitted and enforce them on the backend.

D. Assignment acknowledgement

When a guard receives an assignment:

1. Create a persistent assignment record.
    
2. Notify the guard using Socket.IO.
    
3. Wait for an acceptance or rejection.
    
4. If the guard rejects, make the incident available for reassignment.
    
5. If the acceptance deadline expires, expire the offer and apply the reassignment policy.
    
6. Notify a supervisor if no eligible guard is available.
    

E. Prevent double assignment

Two guards must not be able to accept the same single-guard assignment simultaneously.

Use an atomic database operation, transaction, or conditional state update. A simple sequence of reading an incident and then updating it is not sufficient when multiple requests arrive concurrently.

### Suggested data fields

|Field|Purpose|
|---|---|
|`incidentId`|Incident identifier|
|`assignedGuardId`|Currently assigned guard|
|`assignmentStatus`|Current assignment state|
|`assignedAt`|Assignment timestamp|
|`acceptedAt`|Acceptance timestamp|
|`estimatedDistanceMeters`|Distance at selection time|
|`offerExpiresAt`|Acceptance deadline|
|`reassignmentCount`|Number of reassignment attempts|
|`assignmentReason`|Explanation for the selection|

### Acceptance criteria

- The system never silently treats a notification as a confirmed assignment.
    
- No eligible guard results in a visible unassigned incident and supervisor alert.
    
- Concurrent acceptance requests cannot create conflicting assignments.
    
- Rejections and timeouts trigger the documented reassignment process.
    

Important: If you do not need automatic dispatch for your project, keep proximity-based notifications and accurately describe that feature in the paper. It is not necessary to implement a complex dispatch engine merely to change the wording.

## 4. Reliable and auditable event logging

Priority P0 — Essential

Your paper describes audit logging as non-blocking, with failures caught and logged. This is a significant limitation if you want to claim reliable accountability: an audit event may be lost if the process fails before the event is persisted.

### What you should add

A. Define which events must be audited

At a minimum, record:

- User login and logout events, where applicable.
    
- Patrol shift creation and status changes.
    
- Checkpoint verification attempts, including rejected attempts.
    
- Skipped checkpoints and the reason.
    
- Incident creation, assignment, acceptance, rejection and reassignment.
    
- Supervisor overrides.
    
- Authorization failures for sensitive actions.
    
- Administrative changes to patrol routes, checkpoints and dispatch settings.
    

Avoid recording passwords, JWTs, secrets or unnecessary personal information.

B. Make audit records persistent

Every audit event should contain fields such as:

|Field|Purpose|
|---|---|
|`eventId`|Unique event identifier|
|`actorId`|User who performed the action|
|`action`|Action performed|
|`entityType`|Patrol, checkpoint, incident, etc.|
|`entityId`|Identifier of the affected entity|
|`timestamp`|Server-side event time|
|`outcome`|Success, failure or rejection|
|`metadata`|Relevant, non-sensitive details|
|`correlationId`|Links related requests and events|

C. Choose an explicit failure-handling design

There are two reasonable options.

Recommended

Transactional outbox pattern

Store the business change and an audit/outbox event in the same database transaction. A background worker then publishes or processes the event, retries failures, and marks successful delivery.

Simpler alternative

Best-effort audit logging

Keep asynchronous logging, but add persistent retries and failure metrics where feasible. Clearly disclose any cases in which events can be lost.

The transactional outbox is useful when the database supports the required transactions. If you are using MongoDB, verify your deployment's transaction support before choosing this design.

D. Protect audit records from alteration

- Do not expose ordinary update or delete APIs for audit entries.
    
- Restrict write permissions to the backend service.
    
- Record who performed privileged operations.
    
- Add integrity checks, such as a hash chain, if tamper evidence is an explicit research goal.
    
- Consider immutable or separately controlled storage for stronger protection.
    

A hash chain can help detect modification, but it does not automatically prevent an administrator with sufficient privileges from rewriting the entire chain.

E. Add monitoring

Track metrics such as:

- Number of audit events created.
    
- Number of failed writes.
    
- Number of retry attempts.
    
- Number of events waiting to be processed.
    
- Age of the oldest pending event.
    
- Number of permanently failed events.
    

### Acceptance criteria

- Audit events survive application restarts after being committed to persistent storage.
    
- Temporary processing failures trigger retries.
    
- Duplicate processing does not create duplicate logical audit events.
    
- You can detect and report audit processing failures.
    
- The paper accurately states the level of durability and tamper protection you actually implemented.
    

## 5. Authorization and access control

Priority P0 — Essential

JWT authentication and role-based middleware are useful, but role checks alone do not guarantee that users can access only their own patrols, incidents or locations.

### What you should add

A. Enforce resource ownership

For every protected endpoint, validate both:

1. The user's role.
    
2. The user's relationship to the requested resource.
    

For example, a guard should not be able to update another guard's checkpoint simply by replacing a shift ID in an HTTP request.

B. Validate every sensitive operation

- Only assigned guards can submit ordinary checkpoint updates.
    
- Only authorized supervisors can override or reassign patrols.
    
- Guards should see only the incidents and sites they are permitted to access.
    
- Completed shifts should not be reopened through ordinary endpoints.
    
- Administrative operations should be separately authorized.
    
- Socket.IO connections and event subscriptions must use the same authorization principles as REST APIs.
    

C. Harden JWT handling

Check that the implementation includes:

- Signature verification.
    
- Expiration checks.
    
- Appropriate signing algorithm restrictions.
    
- Required claims, such as subject and role.
    
- A clear strategy for revocation or short-lived tokens, where needed.
    
- Safe token storage and no token leakage in logs.
    

D. Add validation at API boundaries

Use a schema validator, if your stack already supports one, for request bodies, parameters, query strings and identifiers. Reject invalid values before making state changes.

### Acceptance criteria

- A guard cannot access another guard's private patrol data by changing a URL parameter.
    
- A supervisor cannot access resources outside their authorized scope.
    
- Expired or invalid tokens are rejected.
    
- Unauthorized WebSocket subscriptions do not expose live guard locations or incident information.
    

## 6. Live guard location management

Priority P1 — Important

Your paper mentions an in-memory guard location registry. This is useful for a prototype, but it creates problems after server restarts and when multiple application instances are used.

### What you should add

A. Track location freshness

Store the latest location along with:

- Guard ID.
    
- Latitude and longitude.
    
- Server receipt time.
    
- Client capture time.
    
- Accuracy.
    
- Online or offline status.
    

Define a configurable staleness threshold. A location older than that threshold should not be treated as a current location for dispatch.

B. Manage disconnects

When a guard disconnects:

- Update the connection status.
    
- Preserve the last known location with its timestamp.
    
- Exclude the guard from new dispatches if their availability or location is no longer valid.
    
- Handle temporary network loss without instantly creating contradictory states.
    

C. Persist what the system needs

Use persistent storage for the last known location and relevant history if your requirements call for recovery after restart, historical review or reporting.

If only the latest position is needed, you do not necessarily need to retain a complete GPS trail.

D. Prepare for multiple server instances, if required

If you want to run more than one application instance, use shared location state and a compatible event-distribution mechanism. Otherwise, different instances may have inconsistent views of which guards are online.

### Acceptance criteria

- Stale locations are visibly identified and excluded from dispatch according to policy.
    
- Server restarts do not silently turn unknown locations into current locations.
    
- Offline and disconnected guards are handled consistently.
    
- The paper clearly states whether the evaluated deployment uses one server or multiple instances.
    

## 7. Concurrency, atomic updates and idempotency

Priority P1 — Important

Your application may work correctly when one user is testing it, but produce inconsistent results when multiple guards or supervisors act at the same time.

### What you should add

A. Conditional state updates

For example, an incident should be assigned only if its current status is still eligible for assignment. The operation must fail if another request has already assigned it.

B. Version checks

Add a version field or equivalent optimistic concurrency mechanism to records that undergo frequent state transitions.

C. Idempotency

Repeated submissions of the same logical request should not create multiple checkpoint completions, duplicate assignments or duplicate audit events.

D. Consistent update rules

Ensure the following changes cannot partially succeed:

- Marking a shift complete while a checkpoint remains pending.
    
- Assigning one incident to two guards.
    
- Reassigning an incident without recording the reassignment.
    
- Accepting an expired assignment offer.
    
- Updating a patrol after it has been closed.
    

Use database transactions where supported and necessary. Where transactions are unavailable, design explicit recovery and consistency rules.

### Acceptance criteria

Run simultaneous requests against the same incident and checkpoint. Verify that the resulting state is valid and that rejected operations are reported rather than silently overwritten.

## 8. Real-time notifications and failure recovery

Priority P1 — Important

Socket.IO can deliver real-time notifications, but receiving a successful server-side emission does not necessarily mean the intended user received or acknowledged the message.

### What you should add

- Unique notification IDs.
    
- Persistent notification records for important events.
    
- Acknowledgement messages for incident assignments.
    
- Retry or recovery logic for important notifications.
    
- Reconnection handling.
    
- Authorization checks for notification subscriptions.
    
- Delivery and acknowledgement timestamps.
    
- Expiration rules for obsolete assignment offers.
    
- A visible failure state when delivery or acknowledgement times out.
    

For less critical notifications, it may be acceptable to use transient delivery. For important dispatch events, use a persistent assignment record as the source of truth rather than relying on a WebSocket message alone.

### Acceptance criteria

If a guard disconnects when an incident is assigned, the assignment must not disappear or become falsely accepted. When the guard reconnects, the client should be able to retrieve the current assignment state.

## 9. Performance and load-testing infrastructure

Priority P1 — Important for the research paper

Your paper makes performance and scalability claims, so you need a reproducible way to test them. Adding features without measuring their effect will not resolve the experimental limitations.

### What you should add

Create a repeatable load-test script using an appropriate tool such as k6, Artillery or another load-testing framework.

Test the main operations separately:

- Authentication, if part of the measured workload.
    
- Patrol creation and retrieval.
    
- Checkpoint verification.
    
- Live location updates.
    
- Incident creation.
    
- Guard selection and assignment.
    
- Notification delivery.
    
- Audit-event processing.
    

### Suggested test matrix

|Simulated clients|Main purpose|
|---|---|
|100|Baseline|
|250|Moderate concurrency|
|500|Higher concurrency|
|750|Heavy concurrency|
|1,000|Upper test level used in the paper|

Define the workload rather than simply opening many idle connections. For example, specify how frequently each simulated guard sends location updates, how often incidents are created, and how many checkpoints are verified.

### Record these metrics

- Median response latency.
    
- p95 and p99 response latency.
    
- Throughput in requests per second.
    
- Failed requests and timeouts.
    
- CPU and memory utilization.
    
- Notification delivery latency.
    
- Audit processing delay and failures.
    
- Database response time, where measurable.
    

Clearly distinguish:

|Metric|Meaning|
|---|---|
|API latency|Time taken for the API request to complete|
|Notification delivery latency|Time from sending a notification to observing its receipt|
|Acknowledgement latency|Time from assignment offer to guard acceptance|
|Throughput|Successfully completed operations per second|

If the test involves client and server timestamps, account for clock synchronization. If you want true end-to-end measurements, instrument the request flow so you can measure the relevant stages without confusing one-way latency with round-trip time.

Do not hardcode the results. Save the actual measurements and generate the tables and graphs from the collected data.

## 10. Automated security and functional tests

Priority P0 — Essential

Add automated tests that demonstrate the important rules of the system.

### Patrol tests

- A shift cannot complete with pending checkpoints.
    
- A guard cannot update another guard's shift.
    
- A completed shift cannot accept further ordinary checkpoint updates.
    
- Invalid checkpoint coordinates are rejected.
    
- Repeated requests do not duplicate checkpoint events.
    
- Unauthorized skip attempts are rejected.
    

### Incident tests

- A guard outside the permitted scope is not selected.
    
- A stale location is excluded.
    
- No eligible guards results in an unassigned incident.
    
- Two simultaneous acceptance requests cannot assign the same incident twice.
    
- Rejected and expired offers are handled correctly.
    
- Reassignment creates an audit record.
    

### Audit tests

- Successful state changes create the expected audit events.
    
- Rejected operations produce appropriate security logs.
    
- Temporary audit processing failures are retried if retries are part of the design.
    
- Duplicate event processing does not create duplicate logical entries.
    
- Unauthorized modification of audit records is rejected.
    

### Authentication and authorization tests

- Missing, malformed, expired and invalid tokens are rejected.
    
- Role restrictions are enforced.
    
- Resource ownership is enforced.
    
- Unauthorized WebSocket subscriptions are denied.
    

### Failure-recovery tests

- Restart the application and verify that persistent patrol and incident state is preserved.
    
- Simulate database unavailability.
    
- Disconnect a guard during assignment.
    
- Stop the audit processing worker and verify recovery behavior.
    
- Submit concurrent requests to the same resource.
    

Use the testing framework already present in your project if possible. Avoid introducing multiple testing frameworks unnecessarily.

Important: Record which tests actually passed. Do not report planned tests as completed experiments.

## 11. Data model and API improvements

Priority P1 — Important

Before adding new collections or changing your schema, inspect your existing models. The fields below are a target design, not a requirement to duplicate information you already store.

### Suggested entities

Patrol / Shift

Shift ID, assigned guard, route, status, start time, completion time, version.

Checkpoint

Checkpoint ID, coordinates, permitted radius, sequence number, status, verification metadata.

Incident / Assignment

Incident ID, location, priority, status, assigned guard, assignment timestamps, acknowledgement and reassignment details.

Guard Location

Guard ID, coordinates, accuracy, server receipt time, device capture time, freshness and availability.

Audit Event

Event ID, actor, action, affected entity, outcome, timestamp, correlation ID and processing status if needed.

### API improvements

For existing endpoints, preserve their URLs where practical and add validation and authorization inside them.

If you add new functionality, use a consistent structure for responses and errors. For example:

```
{
  "success": false,
  "error": {
    "code": "CHECKPOINT_OUT_OF_RANGE",
    "message": "The reported location is outside the permitted checkpoint radius."
  }
}
```

The response should avoid exposing internal stack traces or sensitive information. Choose appropriate HTTP status codes for invalid input, forbidden access, conflicting state transitions, missing resources and server errors.

## 12. Privacy, data retention and operational controls

Priority P2 — Recommended

Because SPIMS tracks guard locations and work activity, the project should include clear controls over how this information is used.

### What you should add

- Track location only when required for an active shift or another explicitly defined operational purpose.
    
- Restrict access to live locations and location history.
    
- Define how long detailed location records are retained.
    
- Provide authorized supervisors with relevant access logs.
    
- Avoid exposing exact coordinates to users who do not need them.
    
- Secure secrets and environment configuration.
    
- Use HTTPS in deployment and protect WebSocket connections.
    
- Document what happens when a guard loses connectivity or leaves an assigned site.
    
- Define whether the project supports one organization or multiple organizations.
    

### Multi-tenant isolation

If your system is intended for a single organization, you can document that scope. If you claim multi-tenant support, implement and test organization-level isolation across patrols, checkpoints, incidents, locations and audit records.

Do not add complex multi-tenant infrastructure unless it is part of your intended project scope.

## 13. Supervisor dashboard and operational visibility

Priority P2 — Recommended

The interface should make important failures and unresolved states visible instead of merely displaying successful operations.

### Useful additions

Live guard map

Current positions, location freshness, on-duty status and last update time.

Patrol monitoring

Pending checkpoints, missed checkpoints, completed shifts and exceptions.

Incident queue

Unassigned incidents, assignment status, acceptance deadlines and reassignment history.

Audit viewer

Filterable event history with actor, action, outcome, time and entity.

### Acceptance criteria

- Supervisors can identify incidents that are unassigned or awaiting acknowledgement.
    
- Stale locations are visually distinguished from current locations.
    
- Patrol failures and rejected checkpoint submissions are visible.
    
- Audit history can be filtered by incident, patrol, guard and time period, subject to authorization.
    

These are useful improvements, but if your existing UI already provides these capabilities, concentrate on backend correctness and testing instead.

## 14. What you need to change in your research paper after implementing the features

The project and the paper must agree with each other. Once you have implemented and tested the changes, revise the corresponding sections.

|Paper section|What to update|
|---|---|
|Abstract|Describe the final implementation and actual measured results.|
|Proposed methodology|Explain checkpoint validation, assignment logic and audit persistence.|
|Algorithms|Update checkpoint completion, incident dispatch and audit-processing pseudocode.|
|System architecture|Show any new workers, persistent storage, event processing or shared location state.|
|Experimental setup|Document hardware, software, workload, client count and test duration.|
|Results|Include actual median, p95/p99 latency, throughput, failure rate and resource usage.|
|Security analysis|Discuss authorization, GPS spoofing limitations, replay protection and audit integrity.|
|Comparison with related systems|Use verified documentation and explain the criteria used for comparison.|
|Limitations|Explicitly state any remaining single-server, offline, privacy or durability limitations.|

For example, if you add reliable audit persistence, test it under simulated failures, and demonstrate successful recovery, you can describe those results. Until then, don't claim that the system guarantees complete audit history.

# Recommended implementation roadmap

Here is the order I would follow for your existing project.

## Project implementation checklist

### 0/16

### Phase 1 — Correctness

Inspect existing patrol and checkpoint logic

Enforce ownership and valid state transitions

Validate GPS data and checkpoint radius

Correct incident notification versus assignment behavior

### Phase 2 — Reliability

Implement persistent audit events and failure recovery

Prevent concurrent and duplicate assignments

Handle stale locations and reconnects

Validate WebSocket authorization

### Phase 3 — Testing

Add patrol lifecycle tests

Add authorization and security tests

Add incident concurrency tests

Add audit failure and restart tests

### Phase 4 — Evaluation

Build repeatable load tests

Measure latency, throughput and failures

Collect real test results and generate graphs

Update the research paper and limitations

Copy checklist

## 15. What you should prioritize if time is limited

If this is a semester or research project, I would focus on these five deliverables first:

1. Correct patrol lifecycle: No unauthorized checkpoint updates or invalid shift completion.
    
2. Correct incident handling: Clear distinction between notifications and confirmed assignments, with concurrency protection if automatic assignment is implemented.
    
3. Reliable audit records: Persistent events, sensible failure handling and restricted modification.
    
4. Automated tests: Demonstrate that the main security and workflow rules actually work.
    
5. Reproducible performance evaluation: Produce genuine measurements instead of unsupported scalability claims.
    

Features such as advanced route optimization, native mobile applications, multiple-server deployment and elaborate dashboards can wait unless they are required by your intended scope.

## Next step: map these requirements to your actual code

The checklist tells you what to implement, but not yet which existing files and functions need modification.

Share your SPIMS GitHub repository URL or upload the project ZIP. I can then map each requirement to your existing backend routes, models, middleware, Socket.IO handlers, frontend components and test files, separating:

- Already implemented and working.
    
- Partially implemented and needing fixes.
    
- Completely missing and needing new code.
    
- Unnecessary for your current project scope.
    

That will give you a concrete, file-by-file implementation plan without rewriting parts of SPIMS that already work.**
**
