import consumer from "./consumer"

consumer.subscriptions.create("CourceChannel", {
    connected(){
        console.log("Connected to the channel!");
    },

    received(data) {
        cource = data['cource']
        console.log("Receiving")
        console.log(data['cource'])
        update_cource(data)
    }
})

var update_cource = function(data){
    cource = document.getElementById('cource')
    if (cource){
        console.log('Cource set')
        cource.innerText = data['cource']
    }
}