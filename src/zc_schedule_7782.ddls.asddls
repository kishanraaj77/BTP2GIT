@EndUserText.label: 'Projection view for ZI_SCHEDULE_7782'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_schedule_7782
as projection on ZI_schedule_7782
{
key ScheduleUuid,
CourseBegin,
CourseUuid,
@Search.defaultSearchElement: true
Location,
@Search.defaultSearchElement: true
Trainer,
IsOnline,
LastChangedAt,
LocalLastChangedAt,
/* Associations */
_Course : redirected to parent ZC_COURSE_7782
}
