import Ember from 'ember';

export default Ember.Route.extend({
  model: function( params ) {
    console.log( params );
    switch( params.status ) {
      case '401':
        return { status: "401", message: "Unauthorized!" };
      case '404':
        return { status: "404", message: "Not Found!" };
      case '500':
        return { status: "500", message: "Server Error" };
      default:
        return { status: "0", message: "Unknown Error"};
   }
  }
});
