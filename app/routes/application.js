import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class ApplicationRoute extends Route {
  @service mite;
  @service session;
  @service router;

  async model() {
    if (!this.session.data?.token) {
      this.router.transitionTo('login');
      return;
    }

    return {
      myself: await this.mite.myself(),
      account: await this.mite.account(),
    };
  }
}
