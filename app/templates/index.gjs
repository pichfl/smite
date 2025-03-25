import RouteTemplate from 'ember-route-template';
import Component from '@glimmer/component';
import { service } from '@ember/service';

import pageTitle from 'ember-page-title/helpers/page-title';
import { on } from '@ember/modifier';

class IndexRouteComponent extends Component {
  @service session;

  <template>
    {{pageTitle "Index"}}
    {{outlet}}
  </template>
}

// This adapter converts the `<template>` into a route template
export default RouteTemplate(IndexRouteComponent);
