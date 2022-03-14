import { Controller } from "stimulus"
import Splide from '@splidejs/splide';

export default class extends Controller {
  static targets = [ "slider" ]

  connect() {
    new Splide(this.sliderTarget, {
      type: 'fade',
      rewind: true,
      speed: 2000,
      autoplay: true,
      interval: 2000,
      arrows: false,
      pagination: false,
      pauseOnHover: false,
      easing: 'ease-in-out'
    }).mount()
  }
}
