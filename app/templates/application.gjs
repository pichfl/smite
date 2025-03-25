import RouteTemplate from 'ember-route-template';
import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { service } from '@ember/service';

import pageTitle from 'ember-page-title/helpers/page-title';

class ApplicationRouteComponent extends Component {
  @service session;
  @service router;
  logout = () => {
    this.session.set({ organisation: null, token: null });
    this.router.refresh('application');
  };
  <template>
    {{pageTitle "Smite"}}

    <header>
      <div>
        <h1>Smite</h1>

        {{#if @model.account}}
          <nav>
            <a href="https://{{@model.account.name}}.mite.de">Open Mite</a>
          </nav>

          <p>
            {{@model.myself.name}}
            ({{@model.account.title}})
            <button type="button" {{on "click" this.logout}}>Logout</button>
          </p>

        {{/if}}
      </div>
    </header>

    <main>
      {{outlet}}
    </main>
  </template>
}

export default RouteTemplate(ApplicationRouteComponent);
