import Ember from 'ember';
import config from '../config/environment';

export default Ember.Mixin.create({
  decrypt: function( id ){
    if ( !localStorage.private_token )
      return null;
    var url = config.host + "/decrypt/" + id;
    return Ember.$.ajax(url,{
      dataType: 'json',
      headers: { 'PRIVATE_TOKEN': localStorage.private_token }
    });
  }
});
