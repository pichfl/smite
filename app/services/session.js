import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';

const KEY = 'smite';

export default class SessionService extends Service {
  @tracked data;

  constructor() {
    super(...arguments);
    this.data = parse(localStorage.getItem(KEY));
  }

  set(value) {
    localStorage.setItem(KEY, JSON.stringify(value));
    this.data = value;
  }

  get loggedIn() {
    return Boolean(this.data.token);
  }

  // update: (callback) =>
  //   update((value) => {
  //     const newValue = callback(value);
  //     localStorage.setItem(key, JSON.stringify(newValue));
  //     return newValue;
  //   }),
  // reset: () => {
  //   localStorage.removeItem(key);
  //   set(initialValue);
  // },
  // includes: (value) => {
  //   const currentValue = localStorage.getItem(key);
  //   return parse(currentValue).includes(value);
  // },
}

export function parse(value) {
  return value ? JSON.parse(value) : undefined;
}
