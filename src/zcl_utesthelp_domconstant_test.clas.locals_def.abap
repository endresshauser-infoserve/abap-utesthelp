TYPES gy_domain_values TYPE STANDARD TABLE OF dd07v WITH EMPTY KEY.

CLASS lcl_helper DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS determine_constants
      IMPORTING
        iv_class_name    TYPE string
      RETURNING
        VALUE(rt_result) TYPE abap_attrdescr_tab.

    METHODS determine_domain_name
      IMPORTING
        iv_class_name    TYPE string
        is_constant      TYPE abap_attrdescr
      RETURNING
        VALUE(rv_result) TYPE domname.

    METHODS determine_domain_values
      IMPORTING
        iv_domain_name          TYPE domname
      RETURNING
        VALUE(rt_result) TYPE gy_domain_values.
ENDCLASS.
