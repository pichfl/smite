import EyeSlash from 'smite/icons/eye-slash';
import Eye from 'smite/icons/eye';
import Details from './Details';

import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { fn } from '@ember/helper';
import { action } from '@ember/object';
import { tracked } from 'tracked-built-ins';

import eq from 'smite/helpers/eq';

import { parse } from 'smite/services/session';
const KEY = 'hiddenProjects';
const KEY_PREVIOUS = 'previousProject';

export default class InputProjectComponent extends Component {
  hidden;
  @tracked previousProject;

  constructor() {
    super(...arguments);

    this.hidden = tracked(new Set(parse(localStorage.getItem(KEY)) ?? []));
    this.previousProject = parse(localStorage.getItem(KEY_PREVIOUS));
  }

  get projectsByCustomer() {
    return this.args.projects.reduce((acc, { project }) => {
      if (this.hidden.has(project.customerName)) {
        return acc;
      }
      if (!acc[project.customerName]) {
        acc[project.customerName] = [];
      }
      acc[project.customerName].push(project);
      return acc;
    }, {});
  }

  @action
  toggleHidden(id) {
    if (this.hidden.has(id)) {
      this.hidden.delete(id);
    } else {
      this.hidden.add(id);
    }

    localStorage.setItem(KEY, JSON.stringify(Array.from(this.hidden)));
  }

  get hasHidden() {
    return Boolean(this.hidden.size);
  }

  @action
  resetHidden() {
    this.hidden.clear();
    localStorage.setItem(KEY, JSON.stringify(Array.from(this.hidden)));
  }

  @action
  setPreviousProject(value) {
    console.log('previous', value);
    this.previousProject = value;
    localStorage.setItem(KEY_PREVIOUS, this.previousProject);
  }

  <template>
    <fieldset>
      <legend class="hidden">Projects</legend>
      <ul class="customers">
        {{#each-in this.projectsByCustomer as |customer projects|}}
          <li class="customer">
            <h3>
              <span>{{customer}}</span>
              <button
                type="button"
                {{on "click" (fn this.toggleHidden customer)}}
                aria-label="Hide"
              >
                <EyeSlash />
              </button>
            </h3>
            <ul class="projects">
              {{#each projects as |project|}}
                <li class="project checkable">
                  <label>
                    <input
                      type="radio"
                      name="project"
                      value={{project.id}}
                      {{on "click" (fn this.setPreviousProject project.id)}}
                      checked={{eq project.id this.previousProject}}
                    />
                    <span>{{project.name}}</span>
                  </label>
                </li>
              {{/each}}
            </ul>
          </li>
        {{/each-in}}
      </ul>

      {{#if this.hasHidden}}
        <Details @summary="Show hidden">
          <ul class="projects">
            {{#each this.hidden as |name|}}
              <li class="project checkable">
                <span>{{name}}</span>

                <button
                  type="button"
                  {{on "click" (fn this.toggleHidden name)}}
                  aria-label="Show"
                >
                  <Eye />
                </button>
              </li>
            {{/each}}
          </ul>

          <button type="button" {{on "click" this.resetHidden}}>
            Show all
          </button>
        </Details>
      {{/if}}
    </fieldset>
  </template>
}
