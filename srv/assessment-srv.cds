using trial02.assessment as asst from '../db/data-model';

service AssessmentSrv {

    @odata.draft.enabled
    entity Assessment as select from asst.ASSESSMENTS;

    entity Observation as select from asst.OBSERVATIONS;

    entity MasterObservations as select from asst.OBSERVATION_MASTER;
}

annotate AssessmentSrv.Assessment with @(
    UI: {
        LineItem : [
            {
                $Type: 'UI.DataField',
                Value: DESCRIPTION
            },
            {
                $Type: 'UI.DataField',
                Value: START_DATE
            },
            {
                $Type: 'UI.DataField',
                Value: END_DATE
            },           
            {
                $Type: 'UI.DataField',
                Value: createdAt
            },
            {
                $Type: 'UI.DataField',
                Value: createdBy
            }                        
        ],

        FieldGroup #BasicData : {
            $Type : 'UI.FieldGroupType',
            Data: [
                {
                    $Type: 'UI.DataField',
                    Value: DESCRIPTION
                },
                {
                    $Type: 'UI.DataField',
                    Value: START_DATE
                },
                {
                    $Type: 'UI.DataField',
                    Value: END_DATE
                },
                {
                    $Type: 'UI.DataField',
                    Value: createdAt
                },
                {
                    $Type: 'UI.DataField',
                    Value: createdBy
                },
                {
                    $Type: 'UI.DataField',
                    Value: modifiedAt
                },
                {
                    $Type: 'UI.DataField',
                    Value:  modifiedBy
                }                 
            ]
        },

        Facets : [
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#BasicData',
                Label : 'Basic Data',
            },
            {
                $Type: 'UI.ReferenceFacet',
                Target : 'Observation/@UI.LineItem',
                Label: 'Observation'
            }
        ],
    }
){
    ID @UI : { Hidden };
    DESCRIPTION @title: 'Purpose';
    START_DATE @title : 'Start Date';
    END_DATE @title : 'End Date';
}

annotate AssessmentSrv.Observation with @(
    UI:{
        LineItem : [
            {
                $Type: 'UI.DataField',
                Value:  DESCRIPTION                
            },
            {
                $Type: 'UI.DataField',
                Value:  IS_CRITICAL                
            },
            {
                $Type: 'UI.DataField',
                Value:  createdAt               
            }, 
            {
                $Type: 'UI.DataField',
                Value:  createdBy               
            } 
        ],

        FieldGroup #BasicData : {
            $Type : 'UI.FieldGroupType',
            Data: [
                {
                    $Type: 'UI.DataField',
                    Value:  DESCRIPTION                       
                },
                {
                    $Type: 'UI.DataField',
                    Value:  IS_CRITICAL 
                }
            ]
        },

        Facets : [
            {
                $Type : 'UI.ReferenceFacet',
                Target : '@UI.FieldGroup#BasicData',
                Label : 'Basic Data',
            }
        ],
    }

){
    ID @UI : { Hidden };
 //   DESCRIPTION @title : 'Category';
    DESCRIPTION @(
        title : 'Observation',
        Common:{
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'MasterObservations',
                Label : 'Please Select',
                Parameters: [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : DESCRIPTION,
                        ValueListProperty : 'CATEGORY',                        
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'DESCRIPTION',                        
                    }                    
                ]
            },
      }
    );
    IS_CRITICAL @title : 'Is Critical ?';
}
