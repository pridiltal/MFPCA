% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/univDecomp.R
\name{umpcaBasis}
\alias{umpcaBasis}
\title{Calculate an uncorrelated multilinear principal component basis 
representation for functional data on two-dimensional domains}
\usage{
umpcaBasis(funDataObject, npc)
}
\arguments{
\item{funDataObject}{An object of class \code{\link[funData]{funData}} 
containing the observed functional data samples (here: images) for which 
the UMPCA is to be calculated.}

\item{npc}{An integer, giving the number of principal components to be 
calculated.}
}
\value{
\item{scores}{A matrix of scores (coefficients) with dimension 
  \code{N x k}, reflecting the weight of each principal component in each 
  observation.}  \item{B}{A matrix containing the scalar product of all pairs
  of basis functions.} \item{ortho}{Logical, set to \code{FALSE}, as basis 
  functions are not orthonormal.} \item{functions}{A functional data object, 
  representing the functional principal component basis functions.}
}
\description{
This function calculates an uncorrelated multilinear principal component 
analysis (UMPCA) representation for functional data on two-dimensional 
domains. In this case, the data can be interpreted as images with \code{S1 x 
S2} pixels (assuming \code{nObsPoints(funDataObject) = (S1, S2)}), i.e. the 
total observed data are represented as third order tensor of dimension 
\code{N x S1 x S2}.  The UMPCA of a tensor of this kind is calculated via the
\link{UMPCA} function, which is an \code{R}-version of the analogous 
functions in the \code{UMPCA} MATLAB toolbox by Haiping Lu (Link: 
\url{http://www.mathworks.com/matlabcentral/fileexchange/35432}, see also 
references).
}
\section{Warning}{
 As this algorithm aims more at uncorrelated features than 
  at an optimal reconstruction of the data, hence it might give poor results 
  when used for the univariate decomposition of images in MFPCA. The function
  therefore throws a warning.
}

\examples{
# simulate image data for N = 100 observations
N <- 100
b1 <- eFun(seq(0,1,0.01), M = 7, type = "Poly")
b2 <- eFun(seq(-pi, pi, 0.03), M = 8, type = "Fourier")
b <- tensorProduct(b1,b2) # 2D basis functions
scores <- matrix(rnorm(N*56), nrow = N)

# calculate observations (= linear combination of basis functions)
f <- MFPCA:::expandBasisFunction(scores = scores, functions = b)

# calculate basis functions based on UMPCA algorithm (needs some time)
\donttest{
# throws warning as the function aims more at  uncorrelated features than at
# optimal data reconstruction (see help)
umpca <- MFPCA:::umpcaBasis(f, npc = 5) 

oldpar <- par(no.readonly = TRUE)

for(i in 1:5) # plot all 5 basis functions
plot(umpca$functions, obs = i, main = paste("Basis function", i)) # plot first basis function

par(oldpar)}
}
\references{
Haiping Lu, K.N. Plataniotis, and A.N. Venetsanopoulos, 
  "Uncorrelated Multilinear Principal Component Analysis for Unsupervised 
  Multilinear Subspace Learning", IEEE Transactions on Neural Networks, Vol. 
  20, No. 11, Page: 1820-1836, Nov. 2009.
}
\seealso{
\code{\link{univDecomp}}
}
\keyword{internal}
