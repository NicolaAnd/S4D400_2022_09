*&---------------------------------------------------------------------*
*& Report z00_class_new
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_class_new.

INTERFACE lif_partner.
  METHODS: dummy.
  CONSTANTS gc TYPE i VALUE 100.
ENDINTERFACE.

INTERFACE lif_partner2.
  METHODS: dummy.
ENDINTERFACE.

CLASS lcl_handball DEFINITION INHERITING FROM z00_event.

  PUBLIC SECTION.
    INTERFACES lif_partner.
    INTERFACES lif_partner2.

    ALIASES dummy_int_1 FOR lif_partner~dummy.

    DATA: signature_hour TYPE tims.

    METHODS: video_assist
      IMPORTING
        scene                     TYPE tims
      RETURNING
        VALUE(r_decision_correct) TYPE abap_bool,

      get_price_sum REDEFINITION,

      constructor
        IMPORTING
          i_price_child TYPE ty_price
          i_price_adult TYPE ty_price.
    CLASS-METHODS class_constructor.

ENDCLASS.

CLASS lcl_handball IMPLEMENTATION.

  METHOD video_assist.

  ENDMETHOD.

  METHOD get_price_sum.
    r_price_sum = super->get_price_sum(
      i_nr_children = i_nr_children
      i_nr_adults   = i_nr_adults
    ).
    IF i_nr_children > 2.
      r_price_sum -= price_child.
    ENDIF.
  ENDMETHOD.

  METHOD constructor.

    super->constructor( i_start_time = `190000` i_end_time = `213000` ).

    signature_hour = '213000'.

  ENDMETHOD.

  METHOD class_constructor.
    IF 1 = 1. ENDIF.
  ENDMETHOD.

  METHOD dummy_int_1.

  ENDMETHOD.

  METHOD lif_partner2~dummy.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_handball_sap DEFINITION INHERITING FROM lcl_handball.
  PUBLIC SECTION.
    METHODS: dummy.
    METHODS dummy_int_1 REDEFINITION.

ENDCLASS.

CLASS lcl_handball_sap IMPLEMENTATION.
  METHOD dummy.
    me->end_time = ``.
  ENDMETHOD.
  METHOD dummy_int_1.

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.

  DATA(handball) = NEW lcl_handball(
    i_price_adult = '67.89'
    i_price_child = '43.53'
  ).

  DATA(handball_sap) = NEW lcl_handball_sap(
    i_price_adult = '67.89'
    i_price_child = '43.53'
  ).

  DATA: event_object  TYPE REF TO z00_event,
        event_objects TYPE STANDARD TABLE OF REF TO z00_event WITH EMPTY KEY.

  event_object = handball.
  handball->video_assist( scene = CONV tims( '202000' ) ).

  event_object = handball_sap.
  handball_sap->dummy( ).
  "event_object->

  event_objects = VALUE #(
      ( handball )
      ( handball_sap )
  ).

  LOOP AT event_objects INTO event_object.
    WRITE: event_object->name.
    WRITE: event_object->get_price_sum(
        i_nr_children = 4
        i_nr_adults   = 3
    ).
    IF NOT event_object IS INSTANCE OF lcl_handball_sap.
      CONTINUE.
    ENDIF.
    TRY.
        handball = CAST lcl_handball_sap( event_object ).
      CATCH cx_sy_move_cast_error.
        CONTINUE.
    ENDTRY.
    WRITE: handball->signature_hour.
  ENDLOOP.

  DATA(lv) = lif_partner=>gc.
  DATA interface_object TYPE REF TO lif_partner.
  interface_object = handball_sap.
  handball = CAST #( interface_object ).

  DATA(sum) = handball->get_price_sum(
    EXPORTING
      i_nr_children = 3
      i_nr_adults   = 4
  ).

  DATA(name) = handball->name.
