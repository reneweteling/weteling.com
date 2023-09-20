import { createConsumer } from "@rails/actioncable"

export default createConsumer()

// Specify a different URL to connect to
const consumer = createConsumer('/websocket')

consumer.subscriptions.create({ channel: "BbqChannel", room: "Best Room" })
