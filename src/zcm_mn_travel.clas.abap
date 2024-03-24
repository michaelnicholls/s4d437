class ZCM_MN_TRAVEL definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .
  INTERFACES if_abap_behv_message.

  constants: BEGIN OF NO_CARRID_CONNID ,
        msgid TYPE symsgid VALUE 'ZMN_TRAVEL',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
        end of no_carrid_connid.
    constants: BEGIN OF NO_FLIGHTS ,
        msgid TYPE symsgid VALUE 'ZMN_TRAVEL',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'CARRID',
        attr2 TYPE scx_attrname VALUE 'CONNID',
        attr3 TYPE scx_attrname VALUE 'STARTDATE_TXT',
        attr4 TYPE scx_attrname VALUE 'ENDDATE_TXT',
        end of no_flights.
  constants: BEGIN OF FLIGHT_FOUND ,
        msgid TYPE symsgid VALUE 'ZMN_TRAVEL',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'CARRID',
        attr2 TYPE scx_attrname VALUE 'CONNID',
        attr3 TYPE scx_attrname VALUE 'STARTDATE_TXT',
        attr4 TYPE scx_attrname VALUE 'FIRSTDATE_TXT',
        end of flight_found.
  data connid type s_conn_id READ-ONLY.
  data carrid type s_carr_id READ-ONLY.
  data startdate_txt type char10 READ-ONLY.
  data firstdate_txt type char10 READ-ONLY.
    data enddate_txt type char10 READ-ONLY.
  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !severity type if_abap_behv_message~t_severity OPTIONAL
      carrid type s_carr_id optional
      connid type s_conn_id optional
      startdate type sy-datum optional
      firstdate type sy-datum optional
      enddate type sy-datum OPTIONAL.


protected section.
private section.
ENDCLASS.



CLASS ZCM_MN_TRAVEL IMPLEMENTATION.


  method CONSTRUCTOR ##ADT_SUPPRESS_GENERATION.

CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
if_abap_behv_message~m_severity = severity.
 me->startdate_txt = |{ startdate DATE = USER }|.
 me->firstdate_txt = |{ firstdate DATE = USER }|.
 me->enddate_txt = |{ enddate DATE = USER }|.
 me->carrid = carrid.
 me->connid = connid.
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
