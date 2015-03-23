import DS from 'ember-data';

export default DS.Model.extend({
  description: DS.attr('string'),
  username: DS.attr('string'),
  password: DS.attr('string')
});
