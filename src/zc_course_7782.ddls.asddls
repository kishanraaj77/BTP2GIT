@EndUserText.label: 'Projection view for ZI_COURSE_7782'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_COURSE_7782
as projection on ZI_COURSE_7782
{
key CourseUuid,
@Search.defaultSearchElement: true
CourseId,
@Search.defaultSearchElement: true
CourseName,
CourseLength,
@Search.defaultSearchElement: true
@Consumption.valueHelpDefinition: [{ entity: { name:
'I_Country', element: 'Country'} }]
Country,
@Semantics.amount.currencyCode: 'CurrencyCode'
Price,
@Consumption.valueHelpDefinition: [{ entity: { name:
'I_Currency', element: 'Currency'} }]
CurrencyCode,
LastChangedAt,
LocalLastChangedAt,
/* Associations */
_Country,
_Currency,
_Schedule : redirected to composition child ZC_schedule_7782
}

