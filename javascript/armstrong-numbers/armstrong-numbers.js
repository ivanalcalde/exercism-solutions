const sumList = xs => xs.reduce((acc, x) => acc + x, 0)

const powList = exponent => (
  xs => xs.map(x => Math.pow(x, exponent))
)

const digits = number => (
  String(number)
  .split('')
  .map(Number)
)

export function isArmstrongNumber(number) {
  const exponent = String(number).length

  return sumList(
    powList(exponent)(digits(number))
  ) === number
}
