export function decodedValue(colors: string[]): number {
  const decodedStr = colors.slice(0, 2)
    .map(colorValue)
    .map(colorValueToString)
    .join('')

  return Number(decodedStr)
}

function colorValueToString(color: number | undefined): string {
  if (typeof color === "number") return String(color)
  else return ''
}

function colorValue(color: string): number | undefined {
  return {
    black:  0,
    brown:  1,
    red:    2,
    orange: 3,
    yellow: 4,
    green:  5,
    blue:   6,
    violet: 7,
    grey:   8,
    white:  9,
  }[color]
}
