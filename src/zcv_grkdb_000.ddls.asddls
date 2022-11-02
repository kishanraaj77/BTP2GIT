@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'GRKDB 000'
@Metadata.allowextensions : true 

define root view entity ZCV_GRKDB_000 as select from  ZIV_GRKDB_000
  {
    
   key  UserName,
   FirstName,
   LastName
}
