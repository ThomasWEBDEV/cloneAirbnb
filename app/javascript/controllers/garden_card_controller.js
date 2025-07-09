// app/javascript/controllers/garden_card_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { gardenId: Number }

  connect() {
    this.element.addEventListener('mouseenter', this.handleMouseEnter.bind(this))
    this.element.addEventListener('mouseleave', this.handleMouseLeave.bind(this))
  }

  disconnect() {
    this.element.removeEventListener('mouseenter', this.handleMouseEnter.bind(this))
    this.element.removeEventListener('mouseleave', this.handleMouseLeave.bind(this))
  }

  handleMouseEnter() {
    // Dispatch event pour highlight le marqueur
    document.dispatchEvent(new CustomEvent('garden:hover', {
      detail: { gardenId: this.gardenIdValue }
    }))
  }

  handleMouseLeave() {
    // Dispatch event pour unhighlight les marqueurs
    document.dispatchEvent(new CustomEvent('garden:unhover', {
      detail: { gardenId: this.gardenIdValue }
    }))
  }
}
