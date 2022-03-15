import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "display", "thumb" ]

  feature (event) {
    const imgToFeature = event.target.src
    this.displayTarget.src = imgToFeature
  }
}
