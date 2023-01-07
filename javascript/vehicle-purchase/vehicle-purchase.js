// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * Determines whether or not you need a licence to operate a certain kind of vehicle.
 *
 * @param {string} kind
 * @returns {boolean} whether a license is required
 */
export function needsLicense(kind) {
  return ['car', 'truck'].includes(kind)
}

/**
 * Helps choosing between two options by recommending the one that
 * comes first in dictionary order.
 *
 * @param {string} option1
 * @param {string} option2
 * @returns {string} a sentence of advice which option to choose
 */
export function chooseVehicle(option1, option2) {
  const msg = model => `${model} is clearly the better choice.`

  if (option1 < option2) return msg(option1)
  else return msg(option2)
}

/**
 * Calculates an estimate for the price of a used vehicle in the dealership
 * based on the original price and the age of the vehicle.
 *
 * @param {number} originalPrice
 * @param {number} age
 * @returns {number} expected resell price in the dealership
 */



export function calculateResellPrice(originalPrice, age) {
  const cond = conds =>
    conds.find(([isTruthy]) => isTruthy)

  const [_, discount] = cond([
    [age < 3, 0.8],
    [age >=3 && age <=10, 0.7],
    [true, 0.5],
  ])

  return originalPrice * discount
}

// export function calculateResellPrice(originalPrice, age) {
//   const discount = age < 3 ? 0.8
//     : age >= 3 && age <=10 ? 0.7
//     : 0.5
//
//   return originalPrice * discount
// }

// export function calculateResellPrice(originalPrice, age) {
//   const calc = discount => originalPrice * discount
//
//   if(age < 3) return calc(0.8)
//   else if(age >= 3 && age <= 10) return calc(0.7)
//   else return calc(0.5)
// }






