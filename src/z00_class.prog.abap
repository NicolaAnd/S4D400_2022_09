*&---------------------------------------------------------------------*
*& Report z00_class
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_class.

CLASS lcl_class DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.

    DATA: name   TYPE string,
          number TYPE i.
    METHODS: get_number RETURNING VALUE(r_result) TYPE i,
      set_number IMPORTING i_number TYPE i,
      get_name RETURNING VALUE(r_result) TYPE string,
      set_name IMPORTING i_name TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_class IMPLEMENTATION.

  METHOD get_number.
    r_result = me->number.
  ENDMETHOD.

  METHOD set_number.
    me->number = i_number.
  ENDMETHOD.

  METHOD get_name.
    r_result = me->name.
  ENDMETHOD.

  METHOD set_name.
    me->name = i_name.
  ENDMETHOD.

ENDCLASS.
