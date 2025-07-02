import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address"
    })
    this.geocoder.addTo(this.element)

    // Quand une recherche est faite
    this.geocoder.on("result", event => this.#centerMainMap(event))
  }

  #centerMainMap(event) {
    const [lng, lat] = event.result.center
    // Dispatche un événement custom pour la carte principale
    document.dispatchEvent(new CustomEvent("map:center", {
    detail: { lat: lat, lng: lng }
    }))
  }

  disconnect() {
    this.geocoder.onRemove()
  }
}
