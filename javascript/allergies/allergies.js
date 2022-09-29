export class Allergies {
  constructor(flags) {
    this.flags = flags
    this.allergies = {
      eggs: 1,
      peanuts: 2,
      shellfish: 4,
      strawberries: 8,
      tomatoes: 16,
      chocolate: 32,
      pollen: 64,
      cats: 128,
    }
  }

  list() {
    return Object.keys(this.allergies)
      .filter(item => this.allergicTo(item))
  }

  allergicTo(item) {
    return (this.allergies[item] & this.flags) > 0
  }
}
