CLASS z00_event DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES: ty_price  TYPE p LENGTH 6 DECIMALS 2,
           ty_events TYPE STANDARD TABLE OF REF TO z00_event WITH EMPTY KEY.

    DATA: name TYPE string.

    CLASS-METHODS: class_constructor.

    METHODS: constructor
      IMPORTING
        i_start_time TYPE tims
        i_end_time   TYPE tims,

      get_price_sum
        IMPORTING
          i_nr_children      TYPE i
          i_nr_adults        TYPE i
        RETURNING
          VALUE(r_price_sum) TYPE ty_price.

  PROTECTED SECTION.

    DATA: id          TYPE i,
          start_time  TYPE tims,
          end_time    TYPE tims,
          price_child TYPE ty_price,
          price_adult TYPE ty_price.

    METHODS: calculate_duration
      RETURNING
        VALUE(r_duration) TYPE i.

  PRIVATE SECTION.

    CLASS-DATA: number_events TYPE i,
                events        TYPE ty_events.
ENDCLASS.



CLASS z00_event IMPLEMENTATION.
  METHOD calculate_duration.
    r_duration = me->end_time - me->start_time.
  ENDMETHOD.

  METHOD constructor.
    end_time = `220000`.
    start_time = `220000`.
    events = VALUE #( BASE events
        ( me )
    ).
  ENDMETHOD.

  METHOD get_price_sum.
    r_price_sum = 10.
    IF i_nr_adults > 5.
      RETURN.
    ENDIF.
    r_price_sum = i_nr_children * price_child + i_nr_adults * price_adult.
  ENDMETHOD.

  METHOD class_constructor.
    IF 1 = 1. ENDIF.
  ENDMETHOD.


ENDCLASS.
