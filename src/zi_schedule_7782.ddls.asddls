@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Data Definition for ZSCHEDULE_7782'
define view entity ZI_schedule_7782
as select from zschedule_7782 as Schedule
association to parent zi_course_7782 as _Course on
$projection.CourseUuid = _Course.CourseUuid
{
key Schedule.schedule_uuid as ScheduleUuid,
Schedule.course_begin as CourseBegin,
Schedule.course_uuid as CourseUuid,
Schedule.location as Location,
Schedule.trainer as Trainer,
Schedule.is_online as IsOnline,
@Semantics.systemDateTime.lastChangedAt: true
Schedule.last_changed_at as LastChangedAt,
@Semantics.systemDateTime.localInstanceLastChangedAt: true
Schedule.local_last_changed_at as LocalLastChangedAt,
_Course
}
