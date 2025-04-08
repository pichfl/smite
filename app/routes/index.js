import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { today } from '@internationalized/date';

export default class IndexRoute extends Route {
  @service session;
  @service router;
  model() {
    if (this.session.loggedIn) {
      this.router.transitionTo('date', today().toString());
    }
  }
}
