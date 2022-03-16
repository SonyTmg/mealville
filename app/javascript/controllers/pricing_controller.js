import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['total', 'input']
  static values = {
    price: Number
  }

  connect() {
    console.log("pricing")
  }

  calculateTotal(event) {
    // grab all inputs when one changes
    // loop through and calculate total of each (using price dataset attr and value of the input itself)
    // Add all together and display in the total
    // const grandTotal = 0
    // this.inputTargets.forEach((countInput) => {
    //   const guestCount = parseInt(countInput.value, 10)
    //   const price = parseInt(countInput.dataset.price, 10)
    //   const itemTotal = price * guestCount
    //   grandTotal += itemTotal
    // })
    const guestCount = parseInt(event.currentTarget.value, 10)
    let total = guestCount * this.priceValue
    if (Number.isNaN(total)) {
      total = 0
    }
    console.log(total.toFixed(2))
    const formattedPrice = `$${total.toFixed(2)} AUD`
    this.totalTarget.innerHTML = formattedPrice
  }
}
