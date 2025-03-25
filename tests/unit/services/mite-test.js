import { module, test } from 'qunit';
import { setupTest } from 'smite/tests/helpers';

module('Unit | Service | mite', function (hooks) {
  setupTest(hooks);

  // TODO: Replace this with your real tests.
  test('it exists', function (assert) {
    let service = this.owner.lookup('service:mite');
    assert.ok(service);
  });
});
