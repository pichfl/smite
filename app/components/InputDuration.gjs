// import { localStorageStore } from '$stores/localStorage.js';

// const previousDuration = localStorageStore('previousDuration', '0');

// function focusCustom() {
// 	const custom = document.querySelector('input[name="duration-custom"]');
// 	custom.focus();
// }

import Component from '@glimmer/component';
import { action } from '@ember/object';
import { on } from '@ember/modifier';
import { fn } from '@ember/helper';
import { tracked } from 'tracked-built-ins';

import eq from 'smite/helpers/eq';
import { parse } from 'smite/services/session';

const KEY_PREVIOUS = 'previousDuration';

export default class InputDurationComponent extends Component {
  durations = {
    '1h': 60,
    '2h': 120,
    '4h': 240,
    '8h': 480,
  };

  @tracked previous;

  constructor() {
    super(...arguments);

    this.previous = parse(localStorage.getItem(KEY_PREVIOUS));
  }

  @action
  setPrevious(value) {
    this.previous = value;
    localStorage.setItem(KEY_PREVIOUS, this.previous);
  }

  <template>
    <fieldset>
      <legend class="hidden">Duration</legend>

      {{#each-in this.durations as |duration minutes|}}
        <label class="option checkable">
          <input
            type="radio"
            name="duration"
            value={{minutes}}
            {{on "click" (fn this.setPrevious minutes)}}
            checked={{eq minutes this.previous}}
          />
          <span>{{duration}}</span>
        </label>
      {{/each-in}}
    </fieldset>
  </template>
}
