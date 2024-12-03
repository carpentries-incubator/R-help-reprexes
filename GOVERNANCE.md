*Adapted from [carpentries/lesson-development-training](https://github.com/carpentries/lesson-development-training/blob/main/GOVERNANCE.md)*

# Project Governance
This document describes the roles and responsibilities of people who manage the
kaijagahm/R-help-reprexes curriculum
and the way they make decisions about how the project develops.
For information about how to contribute to the project, see [CONTRIBUTING.md](./CONTRIBUTING.md).
For information about the project's Code of Conduct
and its reporting and enforcement mechanisms, see [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md).

## Roles

### Maintainers
A team of 3 Maintainers is responsible for the lesson repository
and makes decisions about changes to be incorporated into the default branch (main).
Changes to the default branch can only be made by pull request,
and all pull requests to the default branch require
review and approval from at least one Maintainer before merging (branch protection ruleset).

Responsibilities of Maintainers include:

* Reviewing and responding to new issues and pull requests in a timely manner
* Attending [Maintainer meetings](#maintainer-meetings) where availability allows
* Voting asynchronously on decisions where needed

#### Maintainer meetings
Maintainer meetings will be scheduled by consensus, beginning with twice-monthly meetings in Fall 2024.
Meeting facilitation and preparation of the [agenda](#meeting-agenda) will rotate between maintainers each meeting.
The facilitator will share the agenda with all Maintainers at least 24 hours before the meeting.
The facilitator will also assign [roles](#meeting-roles) at the start of each meeting.

#### Lead Maintainer
The Lead Maintainer bears the ultimate responsibility for coordinating the activity of the group.
The Lead Maintainer will:
* act as a point of contact for the Maintainer team
* invite other community members to Maintainer meetings as non-voting participants.
* hold veto power during [decision-making](#decision-making)

Where needed e.g. due to absence,
the Lead Maintainer may defer their responsibilities to another member of the Maintainer team.
For now, Kaija Gahm will serve as the Lead Maintainer. 

#### Current Maintainers
See [README.md](./README.md) for a list of the current project Maintainers.

#### Joining/Leaving the Maintainer Team
For now, the Maintainer team consists of Kaija Gahm, Xochitl Ortiz Ross, and Peter Laurin. 
In the future, other Maintainers may join the Maintainer Team, either by volunteering
or by being invited by the existing Maintainers.
Additions to the Maintainer team will be discussed and approved by the current membership.
No formal onboarding exists for new Maintainers,
but some informal onboarding can be expected from the existing Maintainers.

Maintainers may step away from the role at any time,
but are expected to communicate the decision to the whole Maintainer team
and to coordinate with other Maintainers to transfer responsibilities, e.g.
re-assign issues, resolve outstanding pull requests, etc.

### Contributors
Anyone who opens or comments on an issue or pull request,
or who provides feedback on the curriculum through another means,
is considered to be a Contributor to the project.

Maintainers are responsible for ensuring that all such contributions are credited,
e.g. on the curriculum site and/or when a release of the curriculum is made to Zenodo.

## Maintainer Meetings
The Maintainer team meets twice a month, as explained above. Going forward, the
maintainer team must meet at *minimum* 4 times a year for 1 hour, but ideally more often (e.g.
keep the twice-monthly schedule, or transition to monthly).
Meetings provide an opportunity for Maintainers to
discuss outstanding issues and pull requests and co-work on the project where necessary.

### Meeting schedule
The Maintainer meeting schedule is currently not posted publicly and is
agreed upon by the Maintainer team to suit their availability. If additional maintainers
join the project at a later date, the schedule may become more formal.

### Meeting agenda
The agenda for Maintainer meetings will be prepared as a collaborative document,
with (at least) sections to record the following information:

* lists of Maintainers attending and absent from the meeting
* a list of items for discussion and, if necessary, amount of time assigned to each item
  * wherever possible, the list should include a link to the relevant issue/pull request/discussion.
 
Notes will be taken in the agenda, with new meeting agendas/notes being added above 
the notes from the previous meeting.

Meeting agendas and notes can be found in the [Lesson Development doc](https://docs.google.com/document/d/1CkcEyFjr3u1JTos1w9lO0XYcgTJ9wRE6m6LhlwDh1dA/edit#heading=h.awmdspank0xf).

### Meeting roles
Each meeting will have a Facilitator, a Notetaker, and (if needed) a Timekeeper:

* Facilitator:
  introduces agenda items (or delegates this responsibility to another participant)
  and controls the flow of discussion by keeping track of who wishes to speak
  and calling on them to do so.
  The meeting Facilitator is responsible for keeping discussion on-topic,
  ensuring decisions are made and recorded where appropriate,
  and giving every attendee an equal opportunity to participate in the meeting.
  They also act as backup Notetaker, taking over when the Notetaker is speaking.
* Notetaker:
  ensures that the main points of discussion are recorded throughout the meeting.
  Although a full transcript of the discussion is not required,
  the Notetaker is responsible for ensuring that the main points are captured
  and any decisions made and actions required are noted prominently.
* Timekeeper (if needed):
  the Lead Maintainer or meeting Facilitator may choose to assign a Timekeeper,
  whose responsibility is to note the time alloted for each item on the agenda
  and communicate to the Facilitator where that time has run out.
  The decision to move from one agenda item to the next belongs to the meeting Facilitator.

### Decision-making
Decisions within the Maintainer Team will be made by [lazy consensus](https://medlabboulder.gitlab.io/democraticmediums/mediums/lazy_consensus/)
among all Team members, with fallback to simple majority vote only in cases
where a decision must be made urgently and no consensus can be found.

Decisions will preferably be made during Maintainer meetings with every
member of the team present.
Where this is not possible, decision-making will happen asynchronously via
an issue on the curriculum repository.
Decisions made asynchronously must allow at least one week for Maintainers to respond and vote/abstain.

Communication between the Maintainers also happens in a shared Slack channel.
If decisions are made via asynchronous communication in Slack, they will be
recorded in the meeting notes section of the [Lesson Development doc](https://docs.google.com/document/d/1CkcEyFjr3u1JTos1w9lO0XYcgTJ9wRE6m6LhlwDh1dA/edit), or in the 
relevant issue(s), or in a new issue in the repository, to ensure documentation.
