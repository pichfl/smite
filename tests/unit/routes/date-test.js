import { module, test } from 'qunit';
import { setupTest } from 'smite/tests/helpers';

module('Unit | Route | date', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    let route = this.owner.lookup('route:date');
    assert.ok(route);
  });
});
