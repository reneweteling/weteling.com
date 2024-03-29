import { createConsumer } from "@rails/actioncable";

export default createConsumer();

// Specify a different URL to connect to
const consumer = createConsumer("/websocket");

consumer.subscriptions.create(
  { channel: "BbqChannel" },
  {
    // Called when the subscription is ready for use on the server.
    initialized() {
      this.install();
    },

    // Called when the WebSocket connection is closed.
    disconnected() {
      this.uninstall();
    },

    update(data) {
      // Calls `AppearanceChannel#set(data)` on the server.
      this.perform("update", data);
    },

    // Called when the subscription is rejected by the server.
    rejected() {
      this.uninstall();
    },

    received(data) {
      this.addConsole(data);
      if (typeof data == "object" && data["state"]) {
        this.updateState(data["state"]);
      }
    },

    addConsole(data) {
      if (typeof data == "object") {
        data = JSON.stringify(data.state);
      }
      this.output.innerText = this.output.innerText + "\n" + data;
      this.output.scrollTop = this.output.scrollHeight;
    },

    updateState(state) {
      this.state = {
        ...this.state,
        ...state,
      };
      for (const [key, value] of Object.entries(this.state)) {
        switch (key) {
          case "min":
            document.getElementById("currentMin").innerText = value;
            break;
          case "max":
            document.getElementById("currentMax").innerText = value;
            break;
          case "temp":
            document.getElementById("currentTemp").innerText = value;
            break;
          case "targetTemp":
            document.getElementById("targetTemp").value = value;
            break;
          case "pos":
            document.getElementById("currentPos").innerText = value;
            if (
              this.state.min &&
              this.state.max &&
              this.state.min < this.state.max
            ) {
              const delta = this.state.max - this.state.min;
              const pos = this.state.pos - this.state.min;
              this.state.percentage = Math.round((pos / delta) * 100);

              console.log([this.state, delta, pos]);

              document.getElementById(
                "currentPercent"
              ).innerText = `${this.state.percentage} %`;
              document.getElementById(
                "currentProgress"
              ).value = this.state.percentage;
            }
            break;
        }
      }
    },

    install() {
      this.output = document.getElementById("console");
      this.updateState({
        temp: 0,
        pos: 2000,
        targetTemp: 120,
        targetPos: 2000,
        min: 1000,
        max: 4000,
      });

      document
        .getElementById("targetTemp")
        .addEventListener("change", this.updateTarget.bind(this));
      document
        .getElementById("close")
        .addEventListener("click", this.clickclose.bind(this));
      document
        .getElementById("open")
        .addEventListener("click", this.clickopen.bind(this));
      document
        .getElementById("min")
        .addEventListener("click", this.clickMin.bind(this));
      document
        .getElementById("max")
        .addEventListener("click", this.clickMax.bind(this));
    },

    uninstall() {
      document
        .getElementById("close")
        .removeEventListener("click", this.clickclose.bind(this));
    },

    updateTarget() {
      this.update({
        targetTemp: document.getElementById("targetTemp").value,
      });
    },
    clickclose() {
      this.update({ targetPos: this.state.targetPos - 1000 });
    },
    clickopen() {
      this.update({ targetPos: this.state.targetPos + 1000 });
    },
    clickMin() {
      this.update({ min: this.state.pos });
    },
    clickMax() {
      this.update({ max: this.state.pos });
    },
  }
);
