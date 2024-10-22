namespace trial02.assessment;

using { cuid, managed } from '@sap/cds/common';

entity ASSESSMENTS : cuid, managed {
    DESCRIPTION: String(255);
    START_DATE: Date;
    END_DATE: Date;
    CATEGORY: String(35);

    Observation : Composition of many OBSERVATIONS on Observation.ASSESSMENTS = $self;
    ObservationMaster: Association to many OBSERVATION_MASTER on ObservationMaster.CATEGORY = CATEGORY;
}

entity OBSERVATIONS : cuid, managed {
    DESCRIPTION: String(255);
    IS_CRITICAL: Boolean;

    ASSESSMENTS: Association to one ASSESSMENTS;
}

// as master category
entity OBSERVATION_MASTER : cuid {
    CATEGORY: String(35);
    DESCRIPTION: String(255);
}