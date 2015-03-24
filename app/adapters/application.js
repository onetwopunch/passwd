import DS from 'ember-data';
import Ember from 'ember';
import config from '../config/environment';

export default DS.RESTAdapter.extend({
  host: config.host,
  headers: function() {
    console.log("token: " + Ember.$.cookie('private_token'))
    return { "PRIVATE_TOKEN": Ember.$.cookie('private_token') };
  }.property().volatile()
});
