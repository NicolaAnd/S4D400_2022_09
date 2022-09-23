*&---------------------------------------------------------------------*
*& Report z00_select
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_select.

DATA: g_flights TYPE STANDARD TABLE OF sflight WITH EMPTY KEY.

SELECT FROM sflight FIELDS carrid, connid AS connection_id, SUM( price ) AS price
GROUP BY carrid, connid
"HAVING SUM( price ) > 10000
ORDER BY carrid ASCENDING
        INTO TABLE @DATA(g_flights_inline).

        TRY.
    cl_salv_table=>factory(
      IMPORTING
        r_salv_table = DATA(alv)
      CHANGING
        t_table      = g_flights_inline
    ).
  CATCH cx_root.
ENDTRY.

alv->display( ).
