Every event type gets its own document type (to lowercase):

* CommitCommentEvent
* CreateEvent
* DeleteEvent
* DownloadEvent
* FollowEvent
* ForkEvent
* ForkApplyEvent
* GistEvent
* GollumEvent
* IssueCommentEvent
* IssuesEvent
* MemberEvent
* PublicEvent
* PullRequestEvent
* PullRequestReviewCommentEvent
* PushEvent
* ReleaseEvent
* StatusEvent
* TeamAddEvent
* WatchEvent

Extra types:

* commitdata (from repos/:owner/:repo/commits/:sha - issue #27)
* issuedata (from repos/:owner/:repo/issues - issue #31)
