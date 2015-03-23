import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.resource('login', { path: '/' });
  this.resource('profile', { path: '/profile' });
});

export default Router;
