import Ember from 'ember';
export default Ember.Route.extend( {
  actions: {
    error: function( error ){
      console.log( 'ERROR');
      console.log( error );
      if ( error ) {
        if ( error.status === 401 ) {
          console.log('TRANSITIONING TO LOGIN :)');
          this.transitionTo('login');
        } else {
          console.log("Should be transitioning to errors/"+ error.status);
          this.transitionTo('errors', error.status);
        }
      }
    }
  },
});
