import React from 'react';
import {CohortViewTable} from './cohort_view_table';
import reactBootstrapStoryDecorator from '../reactBootstrapStoryDecorator';
import { WorkshopTypes } from '@cdo/apps/generated/pd/sharedWorkshopConstants';

export default storybook => {
  storybook
    .storiesOf('CohortViewTable', module)
    .addDecorator(reactBootstrapStoryDecorator)
    .addStoryTable([
      {
        name: 'Cohort view for teacher application',
        story: () => (
          <CohortViewTable
            data={[
              {
                id: 1,
                date_accepted: '2017-11-01',
                applicant_name: 'Poppy Pomfrey',
                district_name: 'UK Wizarding',
                school_name: 'Hogwarts',
                email: 'nurse@hogwarts.edu',
                notified: 'Yes',
                assigned_workshop: 'TeacherCon Chicago',
                accepted_teachercon: 'Yes',
                tags: []
              },
              {
                id: 2,
                date_accepted: '2017-12-01',
                applicant_name: 'Filius Flitwick',
                district_name: 'UK Wizarding',
                school_name: 'Hogwarts',
                email: 'short@hogwarts.edu',
                notified: 'Yes',
                assigned_workshop: 'TeacherCon Chicago',
                accepted_teachercon: 'No',
                tags: [{id: 3, name: 'charming'}]
              }
            ]}
            viewType="teacher"
            path="path"
            regionalPartnerFilter={{
              value: 2,
              label: "WNY Stem Hub"
            }}
            regionalPartners={[
              {
                id: 1,
                workshop_type: WorkshopTypes.local_summer
              },{
                id: 2,
                workshop_type: WorkshopTypes.teachercon
              }
            ]}
          />
        )
      }, {
        name: 'Cohort view for facilitator application',
        story: () => (
          <CohortViewTable
            data={[
              {
                id: 1,
                date_accepted: '2017-11-01',
                applicant_name: 'Poppy Pomfrey',
                district_name: 'UK Wizarding',
                school_name: 'Hogwarts',
                email: 'nurse@hogwarts.edu',
                notified: 'Yes',
                assigned_workshop: 'Seattle, 5/1',
                registered_workshop: 'Seattle, 5/1',
                assigned_fit: 'Buffalo 6/1',
                registered_fit: 'Yes',
                tags: [{id: 1, name: 'nurse'}, {id: 2, name: "doesn't teach"}]
              },
              {
                id: 2,
                date_accepted: '2017-12-01',
                applicant_name: 'Filius Flitwick',
                district_name: 'UK Wizarding',
                school_name: 'Hogwarts',
                email: 'short@hogwarts.edu',
                notified: 'Yes',
                assigned_workshop: 'Seattle, 5/1',
                registered_workshop: 'Seattle, 5/1',
                assigned_fit: 'Buffalo 7/1',
                registered_fit: 'Yes',
                tags: [{id: 3, name: 'charming'}]
              }
            ]}
            viewType="facilitator"
            path="path"
            regionalPartnerFilter={{
              value: 1,
              label: "A+ College Ready"
            }}
            regionalPartners={[
              {
                id: 1,
                workshop_type: WorkshopTypes.local_summer
              },{
                id: 2,
                workshop_type: WorkshopTypes.teachercon
              }
            ]}
          />
        )
      }
    ]);
};
