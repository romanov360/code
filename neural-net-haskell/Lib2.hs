module Lib2 where

img :: [Int]
img = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,3,18,18,18,126,136,
       175,26,166,255,247,127,0,0,0,0,0,0,0,0,
       0,0,0,0,30,36,94,154,170,253,253,253,253,253,
       225,172,253,242,195,64,0,0,0,0,0,0,0,0,0,
       0,0,49,238,253,253,253,253,253,253,253,253,
       251,93,82,82,56,39,0,0,0,0,0,0,0,0,0,0,0,
       0,18,219,253,253,253,253,253,198,182,247,
       241,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,80,
       156,107,253,253,205,11,0,43,154,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14,1,154,253,
       90,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,139,253,190,2,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,11,190,253,
       70,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,35,241,225,160,108,1,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,81,240,253,
       253,119,25,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,45,186,253,253,150,27,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,93,
       252,253,187,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,249,253,249,64,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,46,130,183,
       253,253,207,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,39,148,229,253,253,253,250,182,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24,114,221,253,
       253,253,253,201,78,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,23,66,213,253,253,253,253,198,81,2,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,18,171,219,253,
       253,253,253,195,80,9,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,55,172,226,253,253,253,253,244,133,11,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,136,253,
       253,253,212,135,132,16,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

label = [0,0,0,0,0,1,0,0,0,0]

imgDouble :: [Double]
imgDouble = map fromIntegral img

layerDouble :: [Double]
layerDouble = map fromIntegral label

inputDim = 784
hiddenDims = [10,10,10]
outputDim = 10

layerDims = [inputDim] <> hiddenDims <> [outputDim]

biases=[ [0.1 | i <- [1..(layerDims !! (l-1))]] | l <- [2..length layerDims]]
-- weights=[ [ [j <- [1..(layerDims !! (l))]] | i <- [1..(layerDims !! (l-1))]] | l <- [2..length layerDims]]
weights=[ [[0.1 | j <- [1..(layerDims !! (l-2))]] | i <- [1..(layerDims !! (l-1))]] | l <- [2..length layerDims]]

-- map (map length) weights
-- map (\l -> (l!!0,length l)) (map (map length) weights)

matrixVector :: [[Double]] -> [Double] -> [Double]
matrixVector mat vec = [ sum $ zipWith (+) (mat!!i) vec | i <- [0..(length mat)-1]]

-- matrixVector (weights !! 0)                                   imgDouble
-- matrixVector (weights !! 1) (matrixVector (weights !! 0) imgDouble)

sigmoid :: Double -> Double
sigmoid x=1/(1+2.71828**(-x))
sigmoid' x=(sigmoid x)*(1 - (sigmoid x))

softmax :: [Double] -> [Double]
softmax layer = 
       let
              exps=map exp layer
              denominator=sum exps
       in
              map (/ denominator) exps

layerActivationSwitch :: Int -> Int -> [Double] -> [Double]
layerActivationSwitch numLayers layerNum =
       case numLayers-2==layerNum of
              True -> softmax
              False -> map sigmoid

layerActivation = layerActivationSwitch (length layerDims)

-- activations = foldl (\::b ::a -> ::b) ::b ::[a] to b
-- b is a list of lists of doubles.
-- a is also a list of lists of doubles.
-- activations = foldl (\)
-- Actually a is just [1..length layerDims], b is a list of lists of doubles.
-- activations = foldl (\activations layerIx -> activations <> [zipWith (+) (matrixVector (weights!!layerIx) (last activations)) (biases!!layerIx)]) [imgDouble] [0..(length layerDims)-2]
-- activations = foldl (\activations layerIx -> activations <> [zipWith (+) (matrixVector (weights!!layerIx) (last activations)) (biases!!layerIx)]) [imgDouble] [0..(length layerDims)-2]

-- Try to get \vec{a} and \vec{z}.
(pre_activations,activations) = foldl (
              \(pre_activations,activations) layerIx ->
                     (
                            pre_activations <> [zipWith (+) (matrixVector (weights!!layerIx) (last activations)) (biases!!layerIx)],
                            activations <> [layerActivation layerIx $ zipWith (+) (matrixVector (weights!!layerIx) (last activations)) (biases!!layerIx)]
                     )
       )
       ([imgDouble],[imgDouble]) 
       [0..(length layerDims)-2]