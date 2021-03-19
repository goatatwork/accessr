import consumer from "./consumer"

consumer.subscriptions.create("ProvisioningFormChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to ProvisioningFormChannel")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    var wall = document.getElementById('provisioning_form_channel');
    wall.innerHTML +=
        "<h2>"+data.name+"</h2>";
  }
});
