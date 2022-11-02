@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Cust 000'
define root view entity ZIV_CUST_00 as select from zdb_cust_000
  {
    key id as Id,
    firstname as Firstname,
    lastname as Lastname,
    age as Age,
    course as Course,
    funding as Funding,
    closewon as Closewon,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt
     
}
