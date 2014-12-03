module Network.Neuron
( Neuron(..)
, sigmoid
, sigmoid'
, logistic
, logistic'
, reclu
, reclu'
, evaluate
, evaluate'
) where

data Neuron = Sigmoid | Logistic | Reclu

-- Evaluate the activation of a neuron by pattern matching it on
-- the constructor.
evaluate :: (Floating a) => Neuron -> [a] -> a
evaluate Sigmoid = sigmoid . sum
evaluate Logistic = logistic . sum
evaluate Reclu = reclu . sum

-- Evaluate the derivative of a neuron, given a floating point vector
evaluate' :: (Floating a) => Neuron -> [a] -> a
evaluate' Sigmoid = sigmoid' . sum
evaluate' Logistic = logistic' . sum
evaluate' Reclu = reclu' . sum

-- The sigmoid activation function, a standard activation function defined
-- on the range (0, 1).
sigmoid :: (Floating a) => a -> a
sigmoid t = 1 / (1 + exp (-1 * t))

-- The derivative of the sigmoid function conveniently can be computed in terms
-- of the sigmoid function.
sigmoid' :: (Floating a) => a -> a
sigmoid' t = s * (1 - s)
              where s = sigmoid t

-- The hyperbolic tangent activation function, another logistic function,
-- but unlike sigmoid it is defined on the range (-1, 1). Unfortunately,
-- we could not call it tanh due to naming conflicts with the Prelude tanh.
logistic :: (Floating a) => a -> a
logistic t = (1 - exp (-2 * t)) / (1 + exp (-2 * t))

-- As with the sigmoid function, the derivative of tanh can be computed in
-- terms of tanh.
logistic' :: (Floating a) => a -> a
logistic' t = 1 - s ^ 2
               where s = logistic t

-- The rectified linear activation function. This is a more "biologically
-- accurate" activation function that still retains differentiability.
reclu :: (Floating a) => a -> a
reclu t = log (1 + exp t)

-- The derivative of the rectified linear activation function is just the
-- sigmoid.
reclu' :: (Floating a) => a -> a
reclu' t = sigmoid t
