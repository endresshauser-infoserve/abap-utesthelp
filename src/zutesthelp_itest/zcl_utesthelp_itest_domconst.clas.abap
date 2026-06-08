"! <p class="shorttext synchronized">integration tests for ZCL_UTESTHELP_ITEST_DOMCONST</p>
"! <p>
"! This class is part of an open-source repository managed via abapGit.
"! </p>
"! <p>
"! SPDX-License-Identifier: MIT
"! </p>
CLASS zcl_utesthelp_itest_domconst DEFINITION
  PUBLIC
  ABSTRACT
  FINAL
  FOR TESTING.

  PUBLIC SECTION.
    "! The data element name is deliberately different from the domain name
    CONSTANTS value_a TYPE zutesthelp_itest_dtel1 VALUE 'A'.
    CONSTANTS value_b TYPE zutesthelp_itest_dtel1 VALUE 'B'.
ENDCLASS.


CLASS zcl_utesthelp_itest_domconst IMPLEMENTATION.
ENDCLASS.
