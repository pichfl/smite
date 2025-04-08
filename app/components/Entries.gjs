// import { task } from 'svelte-concurrency';
import Lock from 'smite/icons/lock';

export let entries = [];

function parseDuration(minutes) {
  const hours = Math.floor(minutes / 60);
  const remainder = minutes % 60;
  return `${hours}h ${remainder ? remainder + 'm' : ''}`;
}

import Component from '@glimmer/component';

export default class EntriesComponent extends Component {
  get entries() {
    return this.args.entries.map((item) => item.timeEntry);
  }
  <template>
    <table>
      <tbody>
        {{#each this.entries as |entry|}}
          <tr>
            <td>{{entry.customerName}}</td>
            <td>{{entry.projectName}}</td>
            <td>{{parseDuration entry.minutes}}</td>
            <td>
              {{#if entry.locked}}
                <Lock />
              {{/if}}
            </td>
            <td>
              <button type="button"> Delete </button>
            </td>
          </tr>
        {{/each}}
      </tbody>
    </table>
  </template>
}
