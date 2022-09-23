*&---------------------------------------------------------------------*
*& Report z00_class_plane_final
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_class_plane_final.

CLASS lcl_airplane DEFINITION.

  PUBLIC SECTION.
    TYPES: BEGIN OF ts_attribute,
             attribute TYPE string,
             value     TYPE string,
           END OF ts_attribute,
           tt_attributes TYPE STANDARD TABLE OF ts_attribute
            WITH NON-UNIQUE KEY attribute.

    METHODS:

      constructor
        IMPORTING iv_name      TYPE string
                  iv_planetype TYPE saplane-planetype
        RAISING   cx_s4d400_wrong_plane,
      set_attributes
        IMPORTING
          iv_name      TYPE string
          iv_planetype TYPE saplane-planetype,

      get_attributes
        EXPORTING
          et_attributes TYPE tt_attributes.

    CLASS-METHODS:
      get_n_o_airplanes EXPORTING ev_number TYPE i,
      class_constructor.
  PROTECTED SECTION.
    DATA: mv_name      TYPE string,
          mv_planetype TYPE saplane-planetype.

  PRIVATE SECTION.



    CLASS-DATA:
      gv_n_o_airplanes TYPE i,
      gt_planetypes    TYPE STANDARD TABLE OF saplane WITH NON-UNIQUE KEY planetype.

ENDCLASS.                    "lcl_airplane DEFINITION
CLASS lcl_airplane IMPLEMENTATION.

  METHOD set_attributes.

    mv_name      = iv_name.
    mv_planetype = iv_planetype.



  ENDMETHOD.                    "set_attributes

  METHOD get_attributes.

    et_attributes = VALUE #(  (  attribute = 'NAME' value = mv_name )
                              (  attribute = 'PLANETYPE' value = mv_planetype ) ).
  ENDMETHOD.                    "display_attributes

  METHOD get_n_o_airplanes.
    ev_number = gv_n_o_airplanes.
  ENDMETHOD.                    "display_n_o_airplanes

  METHOD constructor.
    IF NOT line_exists( gt_planetypes[ planetype = iv_planetype ] ).
      RAISE EXCEPTION TYPE cx_s4d400_wrong_plane.
    ENDIF.
    mv_name = iv_name.
    mv_planetype = iv_planetype.
    gv_n_o_airplanes = gv_n_o_airplanes + 1.
  ENDMETHOD.

  METHOD class_constructor.
    SELECT * FROM saplane INTO TABLE gt_planetypes.
  ENDMETHOD.

ENDCLASS.                    "lcl_airplane IMPLEMENTATION

CLASS lcl_passenger_plane DEFINITION INHERITING FROM lcl_airplane.
  PUBLIC SECTION.
    METHODS constructor IMPORTING iv_name      TYPE string
                                  iv_planetype TYPE saplane-planetype
                                  iv_seats     TYPE i
                        RAISING   cx_s4d400_wrong_plane.
    METHODS get_attributes REDEFINITION.
  PRIVATE SECTION.
    DATA mv_seats TYPE i.
ENDCLASS.

CLASS lcl_passenger_plane IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      EXPORTING
        iv_name      = iv_name
        iv_planetype = iv_planetype
    ).

    mv_seats = iv_seats.
  ENDMETHOD.

  METHOD get_attributes.
    super->get_attributes(
      IMPORTING
        et_attributes = et_attributes
    ).
    et_attributes = VALUE #(  BASE et_attributes ( attribute = 'SEATS' value = mv_seats  ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lcl_cargo_plane DEFINITION INHERITING FROM lcl_airplane.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_name      TYPE string
                iv_planetype TYPE saplane-planetype
                iv_weight    TYPE i
      RAISING   cx_s4d400_wrong_plane.

    METHODS get_attributes REDEFINITION.
    METHODS get_weight RETURNING VALUE(rv_weight) TYPE i.
  PRIVATE SECTION.
    DATA mv_weight TYPE i.
ENDCLASS.

CLASS lcl_cargo_plane IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      EXPORTING
        iv_name      = iv_name
        iv_planetype = iv_planetype
    ).
    mv_weight = iv_weight.
  ENDMETHOD.

  METHOD get_attributes.
    et_attributes = VALUE #(
    ( attribute = 'NAME' value = mv_name )
    ( attribute = 'PLANETYPE' value = mv_planetype )
    ( attribute = 'WEIGHT' value = mv_weight  )
    ).
  ENDMETHOD.

  METHOD get_weight.
    rv_weight = mv_weight.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_carrier DEFINITION.

  PUBLIC SECTION.

    TYPES: tt_planetab TYPE STANDARD TABLE OF REF TO lcl_airplane WITH EMPTY KEY.

    METHODS: add_plane
      IMPORTING
        io_plane TYPE REF TO lcl_airplane,
      get_planes RETURNING VALUE(r_result) TYPE lcl_carrier=>tt_planetab,
      get_highest_cargo_weight
        RETURNING
          VALUE(rv_weight) TYPE i.

  PRIVATE SECTION.

    DATA: mt_planes TYPE tt_planetab.

ENDCLASS.

CLASS lcl_carrier IMPLEMENTATION.

  METHOD add_plane.
    mt_planes = VALUE #( BASE mt_planes ( io_plane ) ).
  ENDMETHOD.

  METHOD get_planes.
    r_result = me->mt_planes.
  ENDMETHOD.

  METHOD get_highest_cargo_weight.
    LOOP AT mt_planes INTO DATA(lo_plane).
      IF lo_plane IS INSTANCE OF lcl_cargo_plane.
        DATA(lo_cargo_plane) = CAST lcl_cargo_plane( lo_plane ).
        rv_weight = nmax( val1 = rv_weight val2 = lo_cargo_plane->get_weight( ) ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

DATA: go_airplane        TYPE REF TO lcl_airplane,
      gt_airplanes       TYPE TABLE OF REF TO lcl_airplane,
      gt_attributes      TYPE lcl_airplane=>tt_attributes,
      gt_output          TYPE lcl_airplane=>tt_attributes,
      go_passenger_plane TYPE REF TO lcl_passenger_plane,
      go_cargo_plane     TYPE REF TO lcl_cargo_plane,
      go_carrier         TYPE REF TO lcl_carrier.

START-OF-SELECTION.

  go_carrier = NEW #( ).

*  TRY.
*      go_airplane = NEW #(
*          iv_name      = 'Plane 1'
*          iv_planetype = '747-400'
*      ).
*      go_carrier->add_plane( io_plane = go_airplane ).
*    CATCH cx_s4d400_wrong_plane.
*  ENDTRY.
*
*  TRY.
*      go_airplane = NEW #(
*          iv_name      = 'Plane 2'
*          iv_planetype = 'A380-800'
*      ).
*      go_carrier->add_plane( io_plane = go_airplane ).
*    CATCH cx_s4d400_wrong_plane.
*  ENDTRY.
*
*  TRY.
*      go_airplane = NEW #(
*          iv_name      = 'Plane 3'
*          iv_planetype = '146-200'
*      ).
*      go_carrier->add_plane( io_plane = go_airplane ).
*    CATCH cx_s4d400_wrong_plane.
*  ENDTRY.

  TRY.
      go_passenger_plane = NEW #(
          iv_name      = 'Plane 10'
          iv_planetype = '146-200'
          iv_seats      = 789
      ).
      go_carrier->add_plane( io_plane = go_passenger_plane ).
    CATCH cx_s4d400_wrong_plane.
  ENDTRY.

  TRY.
      go_cargo_plane = NEW #(
          iv_name      = 'Plane 20'
          iv_planetype = '146-200'
          iv_weight    = 543
      ).
      go_carrier->add_plane( io_plane = go_cargo_plane ).
    CATCH cx_s4d400_wrong_plane.
  ENDTRY.

  TRY.
      go_cargo_plane = NEW #(
          iv_name      = 'Plane 21'
          iv_planetype = '146-200'
          iv_weight    = 999
      ).
      go_carrier->add_plane( io_plane = go_cargo_plane ).
    CATCH cx_s4d400_wrong_plane.
  ENDTRY.

  gt_airplanes = go_carrier->get_planes( ).

  LOOP AT gt_airplanes INTO go_airplane.
    go_airplane->get_attributes(
      IMPORTING
        et_attributes = gt_attributes
    ).

    gt_output = CORRESPONDING #(  BASE ( gt_output  ) gt_attributes ).
  ENDLOOP.

  WRITE: go_carrier->get_highest_cargo_weight( ).

  TRY.
      cl_s4d_output=>display_table( gt_output ).
  CATCH cx_s4d_no_structure.
 ENDTRY.
