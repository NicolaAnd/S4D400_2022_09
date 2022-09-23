*&---------------------------------------------------------------------*
*& Report z00_try_and_error_v01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_try_and_error_v01.

*CLASS lcl_class DEFINITION.
*  PUBLIC SECTION.
*    CLASS-METHODS die
*      CHANGING
*        c_class TYPE REF TO lcl_class.
*    METHODS: I_die.
*ENDCLASS.
*
*CLASS lcl_class IMPLEMENTATION.
*  METHOD die.
*    CLEAR c_class.
*  ENDMETHOD.
*
*  METHOD i_die.
*    die( CHANGING c_class = me ).
*  ENDMETHOD.
*
*ENDCLASS.
*
*START-OF-SELECTION.
*
*  DATA(class) = NEW lcl_class( ).
*  class->i_die( ).
