export const colorCode = (color: string): number | undefined => {
  return {
    black: 0,
    white: 9,
    orange: 3,
  }[color]
}

export const COLORS = [
  'black',
  'brown',
  'red',
  'orange',
  'yellow',
  'green',
  'blue',
  'violet',
  'grey',
  'white',
]
