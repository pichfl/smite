import RouteTemplate from 'ember-route-template';
import Component from '@glimmer/component';
import { service } from '@ember/service';

import pageTitle from 'ember-page-title/helpers/page-title';
import { on } from '@ember/modifier';

class LoginRouteComponent extends Component {
  @service session;
  @service router;

  submit = (event) => {
    event.preventDefault();

    let data = Object.fromEntries(new FormData(event.target).entries());
    const { organisation, token } = data;

    this.session.set({ organisation, token });

    if (organisation && token) {
      this.router.refresh('application');
      return this.router.transitionTo('index');
    }
  };

  <template>
    {{! template-lint-disable require-input-label}}
    {{pageTitle "Login"}}
    <h1>Login</h1>

    <form method="POST" {{on "submit" this.submit}}>
      <p>
        <label for="organisation">Organisation</label>
        <input type="text" value="mainmatter" name="organisation" />
      </p>
      <p>
        <label for="token">Token</label>
        <input type="text" name="token" />
      </p>
      <p>
        <button type="submit">Submit</button>
      </p>
    </form>
  </template>
}

// This adapter converts the `<template>` into a route template
export default RouteTemplate(LoginRouteComponent);
