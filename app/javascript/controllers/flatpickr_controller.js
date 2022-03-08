// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = [ "dates" ]

  connect() {
    // console.log('flatpickr')
    flatpickr(this.datesTarget,
      {
        mode: "range",
        minDate: "today",
        altInput: true,
        altFormat: "F j, Y",
        dateFormat: "d-m-Y",
    })
  }
}
