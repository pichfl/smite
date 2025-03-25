import RouteTemplate from 'ember-route-template';
import Component from '@glimmer/component';
import { service } from '@ember/service';

import pageTitle from 'ember-page-title/helpers/page-title';

import Calendar from 'smite/components/Calendar';
import InputProject from 'smite/components/InputProject';
import InputService from 'smite/components/InputService';
import InputDuration from 'smite/components/InputDuration';
import Entries from 'smite/components/Entries';

import plus from 'smite/icons/plus';

class DateRouteComponent extends Component {
  @service mite;
  @service session;
  @service router;

  logout = () => {
    this.session.set({ organisation: null, token: null });
    this.router.refresh('application');
  };

  submit = (event) => {
    event.preventDefault();
    const formData = new FormData(event.target, event.target.submitter);

    for (const [key, value] of formData) {
      console.log(`${key}: ${value}\n`);
    }

    this.mite.submit({
      date_at: this.args.model.date,
      minutes: formData.get('duration'),
      project_id: formData.get('project'),
      service_id: formData.get('service'),
    });
  };

  <template>
    {{pageTitle "Date"}}
    <Calendar @date={{@model.date}} />

    <form class="select" onsubmit={{this.submit}}>
      <section class="section">
        <InputProject @projects={{@model.projects}} />
      </section>

      <section class="section">
        <InputService @services={{@model.services}} />
      </section>

      <div class="section">
        <div class="action">
          <InputDuration />
          <button type="submit" aria-label="Add">{{plus}}</button>
        </div>

        {{! TODO maybe move this back to a task? }}
        <Entries @entries={{@model.entries}} />
      </div>
    </form>
  </template>
}

export default RouteTemplate(DateRouteComponent);
