@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Travel'
define root view entity zmn_I_TRAVEL
  as select from zmn_travel as t left outer join zmn_tritem as i  on t.trguid = i.trguid
  composition[0..*]of zmn_I_TRAVELITEM as _TravelItem
  
{
  key t.trguid     as Trguid,
      t.agencynum  as AgencyID,
      t.travelid   as TravelID,
      t.trdesc     as TravelDescription,
      t.customid   as CustomerID,
      t.stdat      as StartDate,
      t.enddat     as EndDate,
      t.status     as Status,
      @Semantics.systemDateTime.lastChangedAt: true
      t.changed_at as ChangedAt,
      @Semantics.user.lastChangedBy:  true
      t.changed_by as ChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      t.loc_changed_at as LocalChangedAt,
     cast( (1 + dats_days_between(t.stdat,t.enddat))  as zmn_days) as traveldays,
   cast( count( distinct cast( i.tritemno  as abap.int2 ))  as zmn_numitems)  as numitems,


      _TravelItem
} group by t.trguid,

    t.agencynum,
    t.travelid,
    t.trdesc,
    t.customid,
    t.stdat,
    t.enddat,
    t.status,
    t.changed_at,
    t.changed_by,
    t.loc_changed_at
    
