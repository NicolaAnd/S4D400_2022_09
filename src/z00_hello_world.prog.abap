*&---------------------------------------------------------------------*
*& Report z00_hello_world
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_hello_world.

*DATA: connection_me TYPE z00_t_connections,
*      sflight       TYPE STANDARD TABLE OF sflight WITH EMPTY KEY.
*
*connection_me = VALUE #(
*  ( carrid = `LH`
*    connid = `0400`
*    cityfrom = `FRANKFURT` )
*  ( carrid = `LH`
*    connid = `0401`
*    cityfrom = `FRANKFURT` )
*).
*
**READ TABLE connection_me INTO DATA(connection)
**    WITH TABLE KEY carrid = `LH` connid = `0400`.
**IF sy-subrc = 0.
**  DATA(carrier) = connection-carrid.
**ENDIF.
*
**DATA(cityfrom) = connection_me[ cityfrom = `FRANKFURT` ]-cityfrom.
*connection_me[ cityfrom = `FRANKFURT` ]-cityfrom = `WALLDORF`.
*connection_me[ cityfrom = `FRANKFURT` ] = VALUE #( carrid = `AB` ).
*
*
*
*DATA(g_lines) = lines( connection_me ).
*
*
*LOOP AT connection_me REFERENCE INTO DATA(g_reference).
*  g_reference->cityfrom = `BERLIN`.
*ENDLOOP.
*
*TRY.
*    cl_salv_table=>factory(
*        IMPORTING
*          r_salv_table = DATA(alv)
*        CHANGING
*          t_table = connection_me
*      ).
*  CATCH cx_root.
*ENDTRY.
*
*alv->display( ).
*
*
*
*DATA(int) = 27.
*DATA(ref_int) = REF #( int ).
*
*
*
*
*IF line_exists( connection_me[ 2 ] ).
*  DATA(exists) = connection_me[ 2 ].
*  WRITE: `Juhu`, exists-carrid.
*ELSE.
*  WRITE `Gibts nicht`.
*ENDIF.
*
*sflight = VALUE #(
*  ( carrid = `LH`
*    connid = `0400`
*    currency = 'EUR' )
*).
*
*sflight = CORRESPONDING #( BASE ( sflight ) connection_me ).

*BREAK-POINT.

*PARAMETERS:
*  p_num1 TYPE i,
*  p_num2 TYPE i,
*  p_op   TYPE c LENGTH 1.
*
*DATA(g_result) = CONV s4d400_percentage( 0 ).
*
*CASE p_op.
*  WHEN `+`.
*    g_result = p_num1 + p_num2.
*  WHEN `-`.
*    g_result = p_num1 - p_num2.
*  WHEN `*`.
*    g_result = p_num1 * p_num2.
*  WHEN `/`.
*    IF p_num2 IS NOT INITIAL.
*      g_result = p_num1 / p_num2.
*    ELSE.
*      WRITE: `Division by zero is not allowed.`.
*    ENDIF.
*  WHEN `^`.
*    g_result = 1.
*    DO p_num2 TIMES.
*      g_result = g_result * p_num1.
*    ENDDO.
*  WHEN `%`.
*    CALL FUNCTION 'S4D400_CALCULATE_PERCENTAGE'
*      EXPORTING
*        iv_int1          = p_num1
*        iv_int2          = p_num2
*      IMPORTING
*        ev_result        = g_result
*      EXCEPTIONS
*        division_by_zero = 1
*        OTHERS           = 2.
*ENDCASE.

*WRITE: g_result.

*DATA(string) = substring( val = `Hallo` off = 0 len = 1 ).
*DATA(round) = round( val = '7.72654' prec = 2 mode = cl_abap_math=>round_ceiling ).

data(g_person) = value z00_person( client = 200 id = 6 first_name = `Andreas` ).

insert into z00_person values g_person.
