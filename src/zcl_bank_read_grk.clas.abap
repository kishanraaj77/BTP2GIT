CLASS  ZCL_BANK_READ_GRK DEFINITION PUBLIC FINAL CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS  ZCL_BANK_READ_GRK IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    TRY.
        DATA(lo_http_destination) = cl_http_destination_provider=>create_by_url(
              'https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata/sap/API_BANKDETAIL_SRV/A_BankDetail'
               ).

        "create HTTP client by destination
        DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .

        DATA(lo_web_http_request) = lo_web_http_client->get_http_request( ).

        "adding headers with API Key for API Sandbox
        lo_web_http_request->set_header_fields( VALUE #(
                        (  name = 'Content-Type' value = 'application/json' )
                        (  name = 'Accept'       value = 'application/json' )
                        (  name = 'APIKey'       value = 'lfPtPvAeUX4oUOFyBD02wveJue0urTmT' )
                         ) ).

        "Available Security Schemes for productive API Endpoints
        "Bearer and Basic Authentication
        "lo_web_http_request->set_authorization_bearer( i_bearer = '<...>' ).
        "lo_web_http_request->set_authorization_basic( i_username = '<...>' i_password = '<...>' ).

        "set request method and execute request
        DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>get ).
        DATA(lv_response) = lo_web_http_response->get_text( ).

      CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error.
        "error handling
    ENDTRY.

    out->write( |response:  { lv_response }| ).
  ENDMETHOD.
ENDCLASS.
