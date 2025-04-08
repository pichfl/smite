import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class DateRoute extends Route {
  @service mite;

  async model(params) {
    let projects = await this.mite.projects();
    let services = await this.mite.services();
    let entries = await this.mite.entries(params.date);
    // This route was generated with a dynamic segment. Implement data loading
    // based on that dynamic segment here in the model hook.
    return { ...params, projects, services, entries };
  }
}
