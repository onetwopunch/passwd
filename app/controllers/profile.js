import Ember from 'ember';
import Decryptable from '../mixins/decryptable';

export default Ember.ArrayController.extend( Decryptable, {
  actions: {
    entryDetails: function( id ){
      this.decrypt( id )
      .success( function( data ){
        console.log(data);
      });
    },
  }
});
