CLASS zcl_grk2_00 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    METHODS ADD_DATA.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_grk2_00 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
add_data( ).

  ENDMETHOD.
  METHOD add_data.


    DATA IT_TYPE_CUST TYPE STANDARD TABLE OF ZDB_GRK_000.

    IT_TYPE_CUST = VALUE #(
            ( user_name = 'kishan@faith.com'
            first_name  = 'Kishan'
            last_name  = 'Raaj'    )

            ( user_name = 'raaj@faith.com'
            first_name  = 'John'
            last_name  = 'Rav'    )

            ( user_name = 'Mark@faith.com'
            first_name  = 'Bishan'
            last_name  = 'Rab'    )

             ).
    insert zdb_grk_000 from table @it_type_cust.

  ENDMETHOD.

ENDCLASS.
