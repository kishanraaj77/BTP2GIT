CLASS zcl_http_api_by_url_grk DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_http_api_by_url_grk IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  TRY.
        " create destination by URL
        DATA(lo_http_destination) = cl_http_destination_provider=>create_by_url( 'https://api.chucknorris.io/jokes/random' ).

        "create HTTP client by destination
        DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .

        "set request method and execute request
        DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>get ).

        DATA(lv_text) = lo_web_http_response->get_text( ).

        out->write( |response:  { lv_text }| ).

      CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error.
        "error handling

  endtry .
  ENDMETHOD.
ENDCLASS.
