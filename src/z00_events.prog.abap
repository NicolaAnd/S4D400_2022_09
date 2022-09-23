*&---------------------------------------------------------------------*
*& Report z00_events
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_events.

*TYPES: BEGIN OF tsy_event_all,
*         id          TYPE z00_events-id,
*         kind        TYPE z00_events-kind,
*         name        TYPE z00_events-name,
*         price_adult TYPE z00_events-price_adult,
*         price_child TYPE z00_events-price_child,
*         start_time  TYPE z00_events-start_time,
*         end_time    TYPE z00_events-end_time,
*         event_date  TYPE z00_events-event_date,
*         duration    TYPE i,
*         countdown   TYPE i,
*         costs       TYPE z00_events-price_child,
*       END OF tsy_event_all.

TYPES: BEGIN OF tsy_event_all.
         INCLUDE TYPE z00_events.
TYPES duration TYPE i.
TYPES countdown   TYPE i.
TYPES costs       TYPE z00_events-price_child.
TYPES END OF tsy_event_all.

TYPES tty_event_all TYPE STANDARD TABLE OF tsy_event_all
    WITH NON-UNIQUE KEY event_date.

SELECT FROM z00_events FIELDS *
    WHERE ( event_date = @sy-datlo AND start_time >= @sy-timlo ) OR event_date > @sy-datlo
        INTO TABLE @DATA(g_events).

DATA(g_events_all) = CORRESPONDING tty_event_all( g_events ).
CLEAR g_events.

LOOP AT g_events_all REFERENCE INTO DATA(ref_event).
  ref_event->countdown = ref_event->event_date - sy-datlo.
  ref_event->duration = ( ref_event->end_time - ref_event->start_time ) / 60.
  CASE ref_event->kind.
    WHEN `HB`.
      ref_event->costs = ref_event->price_child + 2 * ref_event->price_adult.
    WHEN `EH`.
      ref_event->costs = 4 * ref_event->price_child + ref_event->price_adult.
    WHEN `KR`.
      ref_event->costs = 6 * ref_event->price_child + 3 * ref_event->price_adult.
  ENDCASE.
ENDLOOP.

IF line_exists( g_events_all[ event_date = `20230123` ] ).
  WRITE: g_events_all[ event_date = `20230123` ]-name.
ELSE.
  WRITE: `No event available.`.
ENDIF.

*TRY.
*    cl_salv_table=>factory(
*      IMPORTING
*        r_salv_table = DATA(alv)
*      CHANGING
*        t_table      = g_events_all
*    ).
*  CATCH cx_root.
*ENDTRY.
*
*alv->display( ).
