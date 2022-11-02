CLASS zcl_bank_read_kr DEFINITION PUBLIC FINAL CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS ZCL_BANK_READ_KR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TRY.
        "  DATA(lo_http_destination) = cl_http_destination_provider=>create_by_url(
        "        'https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata/sap/API_BANKDETAIL_SRV/A_BankDetail' ).

        DATA(lo_http_destination) = cl_http_destination_provider=>create_by_cloud_destination(
                                         i_name                  = 'SAP_BUSINESS_HUB_SANDBOX' " <-- your destination name
                                     "   i_service_instance_name =                            " <-- obsolete - delete this line !!
                                         i_authn_mode            = if_a4c_cp_service=>service_specific ).

        "create HTTP client by destination
        DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .

        DATA(lo_web_http_request) = lo_web_http_client->get_http_request( ).

        lo_web_http_request->set_uri_path( |/s4hanacloud/sap/opu/odata/sap/API_BANKDETAIL_SRV/A_BankDetail?$format=json| ).

        "adding headers with API Key for API Sandbox
        lo_web_http_request->set_header_fields( VALUE #(
                    (  name = 'Content-Type' value = 'application/json' )
                    (  name = 'Accept'       value = 'application/json' )
                    (  name = 'APIKey'       value = 'lfPtPvAeUX4oUOFyBD02wveJue0urTmT' )
                     ) ).

        "set request method and execute request
        DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>get ).
        DATA(lv_response) = lo_web_http_response->get_text( ).

      CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error INTO DATA(lo_exception).
        lv_response = lo_exception->get_text( ).
    ENDTRY.

*    out->write( |response:  { lv_response }| ).

    "test additional
    TYPES: BEGIN OF ty_result,
             BankCountry    TYPE c LENGTH 2,
             BankInternalID TYPE c LENGTH 10,
             BankName       TYPE c LENGTH 30,
             SWIFTCode      TYPE c LENGTH 20,
             CityName       TYPE c LENGTH 50,
           END OF ty_result,

           ty_results TYPE STANDARD TABLE OF ty_result WITH NON-UNIQUE KEY BankCountry BankInternalID,

           BEGIN OF ty_d,
             results TYPE ty_results,
           END OF ty_d,

           BEGIN OF ty_json_response,
             d TYPE ty_d,
           END OF ty_json_response.

    DATA: lv_json    TYPE ty_json_response.

    /ui2/cl_json=>deserialize( EXPORTING json = lv_response
                               CHANGING  data = lv_json ).

    IF lines( lv_json-d-results ) > 0.
      out->write( lines( lv_json-d-results ) ).
      out->write( lv_json-d-results ).
    ELSE.
      out->write( lv_response ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
