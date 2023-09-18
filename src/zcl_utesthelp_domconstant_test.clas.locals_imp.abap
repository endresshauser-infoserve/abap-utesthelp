CLASS lcl_helper IMPLEMENTATION.
  METHOD determine_constants.
    DATA(lo_class_description) = CAST cl_abap_classdescr( cl_abap_typedescr=>describe_by_name( iv_class_name ) ).
    rt_result = lo_class_description->attributes.
    DELETE rt_result WHERE is_constant <> abap_true.
    cl_abap_unit_assert=>assert_not_initial( rt_result ).
  ENDMETHOD.

  METHOD determine_domain_name.
    ASSIGN (iv_class_name)=>(is_constant-name) TO FIELD-SYMBOL(<l_value>).
    cl_abap_unit_assert=>assert_subrc( ).

    DATA(lo_type_description) = cl_abap_typedescr=>describe_by_data( <l_value> ).
    cl_abap_unit_assert=>assert_true( lo_type_description->is_ddic_type( ) ).

    rv_result = lo_type_description->get_relative_name( ).
  ENDMETHOD.

  METHOD determine_domain_values.
    CALL FUNCTION 'DD_DOMVALUES_GET'
      EXPORTING
        domname   = iv_domain_name
      TABLES
        dd07v_tab = rt_result
      EXCEPTIONS
        OTHERS    = 1.

    cl_abap_unit_assert=>assert_subrc( ).
    cl_abap_unit_assert=>assert_not_initial( act = rt_result
                                             msg = |The domain { iv_domain_name } contains no fix values| ).
  ENDMETHOD.
ENDCLASS.
