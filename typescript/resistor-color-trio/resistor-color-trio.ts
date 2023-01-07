export function decodedResistorValue(colors: string[]): string {
  const firstTwoColors = colors.slice(0, 2)
  const thirdColor = colors[2]

  const decodedStr = firstTwoColors
    .map(getColorValue)
    .map(colorValueToString)
    .join('')

  const ohms = colorValueToOhms(getColorValue(thirdColor))

  const resistorValue = Number(decodedStr + ohms)

  return formatResistorValue(resistorValue)
}

function formatResistorValue(resistorValue: number): string {
  const ohmsUnits = getOhmsUnits(resistorValue)

  const ohmsUnitsSortedAsc = [...ohmsUnits]
    .sort(([a], [b]) => a < b ? -1 : 1)

  const [value, unit] = ohmsUnitsSortedAsc[0]

  return `${value} ${unit}`
}

function getOhmsUnits(resistorValue: number): [number, string][] {
  const units: [number, string][] = [
    [resistorValue, 'ohms'],
    [Math.trunc(resistorValue / 1000), 'kiloohms'],
  ]

  return units.filter(([value]) => value > 0)
}

function colorValueToOhms(colorValue: number | undefined): string {
  if (typeof colorValue === "number") {
    return new Array(colorValue).fill('0').join('')
  } else {
    return ''
  }
}

function colorValueToString(colorValue: number | undefined): string {
  if (typeof colorValue === "number") return String(colorValue)
  else return ''
}

function getColorValue(color: string): number | undefined {
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
