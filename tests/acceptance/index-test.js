import { module, test } from 'qunit';
import { visit, currentURL } from '@ember/test-helpers';
import { setupApplicationTest } from 'smite/tests/helpers';

module('Acceptance | index', function (hooks) {
  setupApplicationTest(hooks);

  test('visiting /', async function (assert) {
    await visit('/2025-03-25');

    await assert.dom('h1').containsText('Smite');
    assert.strictEqual(currentURL(), '/2025-03-25');
  });
});
