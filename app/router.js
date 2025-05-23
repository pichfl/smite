import EmberRouter from '@ember/routing/router';
import config from 'smite/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('login');

  this.route('date', {
    path: ':date',
  });
});
