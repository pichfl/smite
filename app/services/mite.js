import Service, { service } from '@ember/service';
import dayjs from 'dayjs';
import camelCase from 'lodash-es/camelCase';

export default class MiteService extends Service {
  @service session;

  async #request(method = 'GET', path = '', body = {}) {
    const { organisation, token } = this.session.data;

    if (!organisation || !token) {
      throw new Error('Unauthenticated.');
    }

    const request = {
      headers: {
        'X-MiteApiKey': token,
        'X-MiteAccount': organisation,
        'X-Requested-With': 'XMLHttpRequest',
      },
      method,
      mode: 'cors',
    };

    if (method !== 'GET') {
      request.headers['Content-Type'] = 'application/json';
      request.body = JSON.stringify(body);
    }

    const response = await fetch(`https://corsapi.mite.de/${path}`, request);
    const json = await response.json();

    if (!response.ok) {
      throw new Error(json.error);
    }

    return transformKeys(json);
  }

  async account() {
    const response = await this.#request('GET', 'account.json');
    return response.account;
  }

  async myself() {
    const response = await this.#request('GET', 'myself.json');
    return response.user;
  }

  async projects() {
    return this.#request('GET', 'projects.json');
  }

  async services() {
    return this.#request('GET', 'services.json');
  }

  async entries(date) {
    const parsed = dayjs(date);

    return this.#request('GET', `daily/${parsed.format('YYYY/MM/DD')}.json`);
  }

  async submit(data) {
    return this.#request('POST', 'time_entries.json', data);
  }
}

function transformKeys(response) {
  // converts keys in objects or arrays of objects to camelCase
  if (Array.isArray(response)) {
    return response.map(transformKeys);
  }

  if (response === null) {
    return null;
  }

  if (typeof response === 'object') {
    const transformed = {};

    for (const [key, value] of Object.entries(response)) {
      transformed[camelCase(key)] = transformKeys(value);
    }

    return transformed;
  }

  return response;
}
