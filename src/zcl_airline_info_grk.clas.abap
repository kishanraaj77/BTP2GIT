CLASS  ZCL_AIRLINE_INFO_GRK DEFINITION PUBLIC FINAL CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS ZCL_AIRLINE_INFO_GRK IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    TRY.
        DATA(lo_http_destination) =
            cl_http_destination_provider=>create_by_cloud_destination(
                                          i_name                  = 'S4D_HTTP_00'
                                          i_authn_mode            = if_a4c_cp_service=>service_specific ).

        DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .
        DATA(lo_web_http_request) = lo_web_http_client->get_http_request( ).

        "set uri path for OData service including the entity to be read
        lo_web_http_request->set_uri_path( |/sap/opu/odata/IWBEP/RMTSAMPLEFLIGHT_2/CarrierCollection?$format=json| ).

        "set request method and execute request
        DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>get ).
        DATA(lv_response) = lo_web_http_response->get_text( ).

      CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error INTO DATA(lx_exception).
        out->write( lx_exception->get_text( ) ).
    ENDTRY.

    TYPES: BEGIN OF ty_result,
             airlineid         TYPE c LENGTH 3,
             airlinename       TYPE c LENGTH 30,
             localcurrencycode TYPE c LENGTH 3,
             url               TYPE c LENGTH 30,
           END OF ty_result,

           ty_results TYPE STANDARD TABLE OF ty_result WITH NON-UNIQUE KEY airlineid,

           BEGIN OF ty_d,
             results TYPE ty_results,
           END OF ty_d,

           BEGIN OF ty_json_response,
             d TYPE ty_d,
           END OF ty_json_response.

    DATA: ls_json    TYPE ty_json_response.

    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = ls_json ).

    IF lines( ls_json-d-results ) > 0.
      out->write( lines( ls_json-d-results ) ).
      out->write( ls_json-d-results ).
    ELSE.
      out->write( lv_response ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
