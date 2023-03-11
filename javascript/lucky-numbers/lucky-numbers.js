// @ts-check

const nFromArray = xs => Number(xs.join(''))

/**
 * Calculates the sum of the two input arrays.
 *
 * @param {number[]} array1
 * @param {number[]} array2
 * @returns {number} sum of the two arrays
 */
export function twoSum(array1, array2) {
  return nFromArray(array1) + nFromArray(array2)
}

/**
 * Checks whether a number is a palindrome.
 *
 * @param {number} value
 * @returns {boolean} whether the number is a palindrome or not
 */
export function luckyNumber(value) {
  const valueInReverse = nFromArray(Array.from(String(value)).reverse())

  return value === valueInReverse
}

/**
 * Determines the error message that should be shown to the user
 * for the given input value.
 *
 * @param {string|null|undefined} input
 * @returns {string} error message
 */
export function errorMessage(input) {
  const valueIsEmpty = x => ['', null, undefined].includes(x)

  if (valueIsEmpty(input)) {
    return 'Required field'
  } else {
    const n = Number(input)

    if (n === 0 || Number.isNaN(n)) return 'Must be a number besides 0'

    return ''
  }
}
