import { Controller } from "stimulus"
import createChannel from "cables/cable";

export default class extends Controller {
  static targets = ['topics']

  initialize() {
    let thisController = this; 
    createChannel( { channel: "TopicsChannel", request_id: this.data.get('request') }, {
      connected() {
        console.log('conntected');
      },
      received( data ) {
        console.log('received info');
        console.log(data);
        thisController.topicsTarget.innerHTML = data['topics'];
      }
    });
  }
}
