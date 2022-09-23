*&---------------------------------------------------------------------*
*& Report z00_fill_events
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_fill_events.

DATA: g_events TYPE STANDARD TABLE OF z00_events WITH EMPTY KEY.

g_events = VALUE #(
    ( id = 1
      kind = `HB`
      name = `Rhein Neckar Löwen`
      event_date = `20221011`
      start_time = `200000`
      end_time = `220000`
      price_child = '37.6'
      price_adult = '49.9' )
    ( id = 2
      kind = `HB`
      name = `Rhein Neckar Löwen`
      event_date = `20221111`
      start_time = `200000`
      end_time = `220000`
      price_child = '37.6'
      price_adult = '49.9' )
    ( id = 3
      kind = `KR`
      name = `Karneval / Fasching`
      event_date = `20221111`
      start_time = `111100`
      end_time = `133000`
      price_child = '8.3'
      price_adult = '17.8' )
    ( id = 4
      kind = `EH`
      name = `Adler Mannheim`
      event_date = `20230117`
      start_time = `183000`
      end_time = `204500`
      price_child = '43.4'
      price_adult = '61.2' )
    ( id = 5
      kind = `EH`
      name = `Adler Mannheim`
      event_date = `20230123`
      start_time = `183000`
      end_time = `204500`
      price_child = '43.4'
      price_adult = '61.2' )
    ( id = 6
      kind = `HB`
      name = `Rhein Neckar Löwen`
      event_date = `20210815`
      start_time = `200000`
      end_time = `220000`
      price_child = '37.6'
      price_adult = '49.9' )
).

MODIFY z00_events FROM TABLE g_events.
