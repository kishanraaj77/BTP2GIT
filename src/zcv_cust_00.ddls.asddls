@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CV for Interface view'
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZCV_CUST_00  as projection on ZIV_CUST_00 as SalesTeam
{
     @EndUserText.label: 'Id'

    key Id,

    

 @EndUserText.label: 'First Name'

     @Search.defaultSearchElement: true

     Firstname,

     

     

     @EndUserText.label: 'Last Name'

     @Search.defaultSearchElement: true

     Lastname,

     

     @EndUserText.label: 'Age'

     Age,

     

     @Search.defaultSearchElement: true

     @EndUserText.label: 'Course Applied for '

     Course,

     @EndUserText.label: 'Funding in percentage '

     Funding,

     @EndUserText.label: 'Close Won '

     Closewon,

     LastChangedAt,

     LocalLastChangedAt

     
}
