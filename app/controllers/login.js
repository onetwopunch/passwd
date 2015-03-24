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
          var ret = Ember.$.cookie('private_token', data.private_token, {expires: 1/12});
          console.log(ret);
          controller.transitionToRoute('profile');
        }
      });
    }
  }
});
