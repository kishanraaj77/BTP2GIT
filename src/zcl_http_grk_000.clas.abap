class ZCL_HTTP_GRK_000 definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_HTTP_GRK_000 IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

   DATA(system_date) = cl_abap_context_info=>get_system_date( ).
DATA: text TYPE string.
text = system_date.
response->set_text( | { system_date DATE = USER } | ).



  endmethod.
ENDCLASS.
