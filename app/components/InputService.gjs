import EyeSlash from 'smite/icons/eye-slash';
import Eye from 'smite/icons/eye';
import Details from './Details';

const KEY = 'hiddenServices';
const KEY_PREVIOUS = 'previousService';

import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { fn } from '@ember/helper';
import { tracked } from 'tracked-built-ins';
import { action } from '@ember/object';

import { parse } from 'smite/services/session';
import eq from 'smite/helpers/eq';

export default class InputServiceComponent extends Component {
  hidden;
  @tracked previous;

  constructor() {
    super(...arguments);

    this.hidden = tracked(new Set(parse(localStorage.getItem(KEY)) ?? []));
    this.previous = parse(localStorage.getItem(KEY_PREVIOUS));
  }

  get visibleServices() {
    return this.args.services
      .filter(({ service: { id } }) => !this.hidden.has(id))
      .map((item) => item.service);
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
  serviceName(serviceId) {
    let service = this.args.services.find((s) => s.service.id === serviceId);
    return service.service.name;
  }

  @action
  setPrevious(value) {
    this.previous = value;
    localStorage.setItem(KEY_PREVIOUS, this.previous);
  }

  <template>
    <fieldset>
      <legend class="hidden">Services</legend>
      <ul class="services">
        <li class="checkable">
          <label>
            <input
              type="radio"
              name="service"
              value=""
              {{on "click" (fn this.setPrevious "")}}
              checked={{eq "" this.previous}}
            />
            <span>None</span>
          </label>

          <button
            type="button"
            {{on "click" (fn this.toggleHidden @id)}}
            aria-label="Hide"
          >
            <EyeSlash />
          </button>
        </li>

        {{#each this.visibleServices as |service|}}
          <li class="checkable">
            <label>
              <input
                type="radio"
                name="service"
                value={{service.id}}
                {{on "click" (fn this.setPrevious service.id)}}
                checked={{eq service.id this.previous}}
              />
              <span>{{service.name}}</span>
            </label>

            <button
              type="button"
              {{on "click" (fn this.toggleHidden service.id)}}
              aria-label="Hide"
            >
              <EyeSlash />
            </button>
          </li>
        {{/each}}
      </ul>

      {{#if this.hasHidden}}
        <Details @summary="Hidden services">
          <ul class="services">
            {{#each this.hidden as |serviceId|}}
              <li class="checkable">
                <label>
                  <input type="radio" name="service" value={{serviceId}} />
                  <span>{{this.serviceName serviceId}}</span>
                </label>

                <button
                  type="button"
                  {{on "click" (fn this.toggleHidden serviceId)}}
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
