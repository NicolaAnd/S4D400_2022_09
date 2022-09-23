*&---------------------------------------------------------------------*
*& Report z00_itab
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_itab.

*DATA: g_connections TYPE z00_t_connections,
*      g_flights     TYPE d400_t_flights,
*      g_percentages TYPE d400_t_percentage.
*
*g_connections = VALUE #(
*  ( carrid = `LH` connid = `0400` )
*  ( carrid = `LH` connid = `0402` )
*).
*
*CALL FUNCTION 'Z_00_GET_FLIGHTS_FOR_CONNECT'
*  EXPORTING
*    it_connections = g_connections
*  IMPORTING
*    et_flights     = g_flights
*  EXCEPTIONS
*    no_data        = 1
*    OTHERS         = 2.
*
*g_percentages = CORRESPONDING #( g_flights ).
*
*LOOP AT g_percentages REFERENCE INTO DATA(g_percentage).
*  IF g_percentage->seatsmax IS NOT INITIAL.
*    g_percentage->percentage = g_percentage->seatsocc / g_percentage->seatsmax * 100.
*  ENDIF.
*ENDLOOP.
*
*SORT g_percentages BY percentage DESCENDING.
*
*TRY.
*    cl_salv_table=>factory(
*      IMPORTING
*        r_salv_table = DATA(alv)
*      CHANGING
*        t_table      = g_percentages
*    ).
*  CATCH cx_root.
*ENDTRY.
*
*alv->display( ).

TRY.
    DATA(result) = 7 / 0.
  CATCH cX_SY_ZERODIVIDE.
    WRITE: `Bad`.
ENDTRY.
