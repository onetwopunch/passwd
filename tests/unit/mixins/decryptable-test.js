import Ember from 'ember';
import DecryptableMixin from '../../../mixins/decryptable';
import { module, test } from 'qunit';

module('DecryptableMixin');

// Replace this with your real tests.
test('it works', function(assert) {
  var DecryptableObject = Ember.Object.extend(DecryptableMixin);
  var subject = DecryptableObject.create();
  assert.ok(subject);
});
