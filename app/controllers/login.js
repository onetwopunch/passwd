import Ember from 'ember';
import config from '../config/environment';

export default Ember.Controller.extend({
  actions: {
    login: function() {
      var email = $("#inputEmail").val(),
          password = $("#inputPassword").val(),
          url = config.host + "/login";
      var params = { email: email, password: password };
      $.post( url, params, function(data) {
        console.log( data );
      });

    }
  }
});
