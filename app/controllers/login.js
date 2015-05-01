import Ember from 'ember';
import config from '../config/environment';

export default Ember.Controller.extend({
  actions: {
    login: function() {
      var email = Ember.$("#inputEmail").val(),
          password = Ember.$("#inputPassword").val(),
          url = config.host + "/login";
      var params = { email: email, password: password };
      var controller = this;
      Ember.$.post( url, params, function(data) {
        data = JSON.parse(data);
        console.log( data );

        if ( data.private_token ) {
          localStorage.private_token = data.private_token;
          controller.transitionToRoute('profile');
        }
      });
    }
  }
});
