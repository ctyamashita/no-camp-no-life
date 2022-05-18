import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "output", "garage", 'myBookings' ]

  connect() {
    console.log('connected')
    this.garageTarget.classList.add('hidden-table')
  }

  display() {
    this.garageTarget.classList.remove('hidden-table')
    this.myBookingsTarget.classList.add('hidden-table')
  }

  displayBookings() {
    this.myBookingsTarget.classList.remove('hidden-table')
    this.garageTarget.classList.add('hidden-table')
  }
}
