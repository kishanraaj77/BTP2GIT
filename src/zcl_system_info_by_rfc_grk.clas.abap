CLASS zcl_system_info_by_rfc_grk DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_system_info_by_rfc_grk IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATA msg TYPE c LENGTH 255.
DATA lv_result TYPE c LENGTH 200.
TRY.
DATA(lo_rfc_dest) =
cl_rfc_destination_provider=>create_by_cloud_destination( |S4D_RFC| ).
DATA(lv_rfc_dest) = lo_rfc_dest->get_destination_name( ).
CALL FUNCTION 'RFC_SYSTEM_INFO' DESTINATION lv_rfc_dest
IMPORTING
rfcsi_export = lv_result
EXCEPTIONS
system_failure = 1 MESSAGE msg
communication_failure = 2 MESSAGE msg
OTHERS = 3.
CASE sy-subrc.
WHEN 0.
out->write( lv_result ).
WHEN 1.
out->write( |EXCEPTION SYSTEM_FAILURE | && msg ).
WHEN 2.
out->write( |EXCEPTION COMMUNICATION_FAILURE | && msg ).
WHEN 3.
out->write( |EXCEPTION OTHERS| ).
ENDCASE.
CATCH cx_root INTO DATA(lx_root).
out->write( lx_root->get_text( ) ).
ENDTRY.
ENDMETHOD.

ENDCLASS.
