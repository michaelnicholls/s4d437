@EndUserText.label: 'Flight Travel'
@AccessControl.authorizationCheck: #CHECK

@Search.searchable: true

@Metadata.allowExtensions: true

define root view entity zmn_C_TRAVEL
  as projection on zmn_I_TRAVEL
  
{
  key Trguid,
      @Search.defaultSearchElement: true
      AgencyID,
      TravelID,
      TravelDescription,

      @Consumption.valueHelpDefinition: [{
                       entity: {
                                 name:    'D437_I_Customer',
                                 element: 'Customer'
                               }
                                        }]

      @Search.defaultSearchElement: true
      CustomerID,
      StartDate,
      EndDate,
      Status,
      ChangedAt,
      ChangedBy,

      LocalChangedAt,
      traveldays, numitems,
      
      _TravelItem: redirected to composition child zmn_C_TRAVELITEM
}
