import Ember from 'ember';

export default Ember.Route.extend({
  beforeModel: function() {
    if ( localStorage.private_token ){ this.transitionTo('profile') }
  }
});
