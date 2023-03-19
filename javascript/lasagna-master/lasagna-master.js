/// <reference path="./global.d.ts" />
// @ts-check

export function cookingStatus(t) {
  if (t === undefined) return 'You forgot to set the timer.'
  if (t === 0) return 'Lasagna is done.'

  return 'Not done, please wait.'
}

export function preparationTime(layers = [], t = 2) {
  const layersCount = layers.length

  if (layersCount === 0) return 0

  return layersCount * t
}

export function quantities(layers) {
  const countLayers = (layer, layers) => layers.filter(l => l === layer).length

  return {
    noodles: 50 * countLayers('noodles', layers),
    sauce: 0.2 * countLayers('sauce', layers),
  }
}

export function addSecretIngredient(friendList, myList) {
  const last = xs => xs[xs.length - 1]

  myList.push(last(friendList))
}

export function scaleRecipe(recipeForTwo, numberOfPeople) {
  const scale = numberOfPeople / 2

  return Object.entries(recipeForTwo).reduce((acc, [key, value]) => ({
    ...acc,
    [key]: value * scale,
  }), {})
}
