CLASS lhc_salesteam DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR salesteam RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR salesteam RESULT result.

    METHODS setcw FOR MODIFY
      IMPORTING keys FOR ACTION salesteam~setcw RESULT result.

    METHODS fundingchange FOR DETERMINE ON SAVE
      IMPORTING keys FOR salesteam~fundingchange.

    METHODS validateage FOR VALIDATE ON SAVE
      IMPORTING keys FOR salesteam~validateage.

ENDCLASS.

CLASS lhc_salesteam IMPLEMENTATION.

  METHOD get_instance_features.

        read  ENTITIES OF ZIV_CUST_00 IN LOCAL MODE  ENTITY SalesTeam
        fields (  Closewon  )    with CORRESPONDING #( keys )
        RESULT DATA(members)
        FAILED failed .
        result =
        value #(
        for member in members


        LET status = COND #(  WHEN member-Closewon =  abap_true
        then if_abap_behv=>fc-o-disabled
        else if_abap_behv=>fc-o-enabled  )

         in

         (  %tky = member-%tky
         %action-setcw = status
            )
            ).




  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD setcw.

  modify    ENTITIES OF ZIV_CUST_00 IN LOCAL MODE  ENTITY SalesTeam


  update FIELDS (  Closewon )
  WITH VALUE #( for key in  keys (
   %tky   = key-%tky
     Closewon = abap_true ) )
     FAILED failed
     REPORTED reported.


  ENDMETHOD.

  METHOD fundingchange.

  READ  ENTITIES OF ZIV_CUST_00 IN LOCAL MODE  ENTITY SalesTeam
    FIELDS ( Age  ) with CORRESPONDING  #( keys )
    RESULT DATA(members).
  loop at members   into data(member).
    if member-Age > 40 .

    modify ENTITIES OF ZIV_CUST_00 IN LOCAL MODE  ENTITY SalesTeam
    update FIELDS ( Funding )
    WITH VALUE #( (  %tky = member-%tky
    Funding = 90 ) ) .
    ENDIF.

     if member-Age < 40 .

    modify ENTITIES OF ZIV_CUST_00 IN LOCAL MODE  ENTITY SalesTeam
    update FIELDS ( Funding )
    WITH VALUE #( (  %tky = member-%tky
    Funding = 70 ) ) .
    ENDIF.

  ENDLOOP.
  ENDMETHOD.

  METHOD validateage.

    READ  ENTITIES OF ZIV_CUST_00 IN LOCAL MODE  ENTITY SalesTeam
    FIELDS ( Age  ) with CORRESPONDING  #( keys )
    RESULT DATA(members).

    loop at members   into data(member).
    if member-Age < 21 .
    append value #(  %tky = member-%tky )  to failed-salesteam.
    endif.
    endloop.






  ENDMETHOD.

ENDCLASS.
