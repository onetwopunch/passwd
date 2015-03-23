import DS from 'ember-data';

export default DS.Model.extend({
  email: DS.attr('string'),
  private_token: DS.attr('string'),
  entries: DS.has_many('entry')
});
