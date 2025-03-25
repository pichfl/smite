// import { createCalendar, melt } from '@melt-ui/svelte';
import { today, parseDate, isWeekend } from '@internationalized/date';

import ChevronLeft from 'smite/icons/chevron-left';
import ChevronRight from 'smite/icons/chevron-right';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { action } from '@ember/object';

// const {
// 	elements: { calendar, heading, grid, cell, prevButton, nextButton },
// 	states: { months, headingValue, weekdays, value },
// 	helpers: { isDateDisabled, isDateUnavailable },
// 	options: { locale },
// } = createCalendar({
// 	defaultValue: $page.params.date ? parseDate($page.params.date) : today(),
// 	weekStartsOn: 1,
// });

// export let onSelectDate = () => {};

// locale.set('en-US');

// function selectDate(date) {
// 	value.set(date);
// 	onSelectDate(date);
// }

import Component from '@glimmer/component';

import { service } from '@ember/service';
import { format } from 'date-fns';
import { getDaysInMonth } from 'date-fns';

export default class CalendarComponent extends Component {
  @service router;

  selectDate(date) {
    this.router.transitionTo('date', date.toString());
  }

  get today() {
    return today();
  }

  get date() {
    return parseDate(this.args.date);
  }

  get headingValue() {
    return format(this.date, 'MMMM yyyy');
  }

  get days() {
    return Array.from({ length: getDaysInMonth(this.date) }, (_, i) => i + 1);
  }

  @action
  selectDay(day) {
    this.selectDate(this.date.set({ day }));
  }

  @action
  isSelected(day) {
    return this.date.day === day;
  }

  @action
  isToday(day) {
    return this.today.day === day;
  }

  @action
  isWeekend(day) {
    return isWeekend(this.date.set({ day }), 'en-US');
  }

  @action
  previousDay() {
    this.selectDate(this.date.set({ day: this.date.day - 1 }));
  }

  @action
  nextDay() {
    this.selectDate(this.date.set({ day: this.date.day + 1 }));
  }

  <template>
    <div data-melt-calendar>
      <header>
        <button type="button" {{on "click" this.previousDay}}><ChevronLeft
          /></button>
        <div>
          {{this.headingValue}}
        </div>
        <button type="button" {{on "click" this.nextDay}}><ChevronRight
          /></button>
      </header>
      <div>
        <table>
          <thead aria-hidden="true">
            <tr>
              {{#each this.weekdays as |day|}}
                <th>
                  {{day}}
                </th>
              {{/each}}
            </tr>
          </thead>
          <tbody>

            <tr>
              {{#each this.days as |day|}}
                <td
                  {{!-- aria-disabled={{$isDateDisabled(date) || $isDateUnavailable(date)}} --}}
                >
                  <button
                    type="button"
                    aria-selected={{this.isSelected day}}
                    data-today={{this.isToday day}}
                    data-weekend={{this.isWeekend day}}
                    {{on "click" (fn this.selectDay day)}}
                  >
                    {{day}}
                  </button>
                </td>
              {{/each}}
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </template>
}
