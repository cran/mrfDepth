\name{depthContour}
\alias{depthContour}
\title{Depth contours of multivariate data}
\description{
Computes the vertices of depth contours of multivariate data. The contours can be
computed based on halfspace depth, projection depth, skewness-adjusted projection 
depth or directional projection depth. To make the actual plot for bivariate data, 
the function \code{plotContours} needs to be called on the result of \code{depthContour}.
}
\usage{
depthContour(x, alpha = NULL, type = "hdepth", directions = NULL, options = NULL)
}
\arguments{
	\item{x}{An \eqn{n} by \eqn{p} data matrix.}
	\item{alpha}{A vector containing the depth values of which the depth
	             contours have to be computed.}
  \item{type}{The depth used in the computation of the contours:
              \code{hdepth} for halfspace depth, \code{projdepth} for projection depth, 
              \code{sprojdepth} for skewness-adjusted projection depth and 
              \code{dprojdepth} for directional projection depth. \cr
              Defaults to \code{hdepth}.
              }
  \item{directions}{An \eqn{m} by \eqn{p} matrix specifying the directions
                    on which to compute the vertices (see Details). }
  \item{options}{A list of options to pass to \code{hdepth}, \code{projdepth},
                \code{sprojdepth} or \code{dprojdepth}.
                 In addition the following option may be specified:
                  \itemize{
                      \item{ \code{max.iter} \cr
                            The maximum number of iterations in the bisection algorithm used
                            to compute the depth contour corresponding to level alpha. \cr
                            Defaults to \eqn{100}.
                           }
                          }
                }
}
\details{
Depth contours of level \eqn{\alpha} (or \eqn{\alpha}-depth contours) are the boundaries of depth regions. Depth regions of level \eqn{\alpha} are defined as regions in space containing the multivariate points whose depth value is at least \eqn{\alpha}.

For bivariate data halfspace depth contours can be computed exactly following the algorithm in Ruts and Rousseeuw (1996). When the data are not in general position (i.e. when there is a line containing more than two observations) dithering is performed by adding random Gaussian noise to the data.

In all other cases an approximated method is performed using a bisection algorithm. Intersections with the depth contours are searched on lines originating from the depth median. The user can specify a set of directions corresponding to these lines. By default a random set of \eqn{250p} directions is considered. On each direction a point is searched having depth \eqn{\alpha}. Starting limits are obtained by projecting the data on the direction and considering the data point with univariate depth \eqn{\alpha}. By definition the multivariate depth of this point has to be lower or equal to \eqn{\alpha}. A second limit is obtained by considering the deepest location estimate. The maximum number of iterations bisecting the current search interval can be specified through the options argument \code{max.iter}.  Note that this method is only affine or rotation equivariant if the chosen directions are affine or rotation equivariant.

It is first checked whether the data is found to lie in a subspace of
dimension lower than \eqn{p}. If so, the routine will give a warning, giving
back the dimension of the subspace together with a direction describing a
hyperplane containing this subspace.
}
\value{
The output consists of a list. Each element of the list contains the following elements for each value \eqn{\alpha} specified in the argument \code{alpha}.
	\item{depth}{The depth of the depth contour of level \eqn{\alpha}. For halfspace depth this is equal to \eqn{floor(\alpha n)/n}. For projection depth, skewness-adjusted projection depth and directional depth, this equals to \eqn{\alpha}.}
	\item{vertices}{The coordinates of the vertices of the depth contour.}
	\item{empty}{Logical indicating whether the corresponding depth region is empty. \cr
                \code{FALSE} indicates the depth region is non-empty. \cr
                \code{TRUE} indicates the depth region is empty. \cr
                }
	\item{dithered}{Logical indicating whether dithering has been applied in the exact bivariate algorithm based on halfspace depth. \cr
                \code{FALSE} indicates no dithering has been applied. \cr
                \code{TRUE} indicates dithering has been applied.}
  \item{converged}{A vector of length \eqn{m} containing a flag indicating for each direction whether convergence was reached by the bisecting algorithm within the allowed \code{max.iter} number of steps. }
  \item{type}{Same as input parameter type.}
  \item{dimension}{If the data are lying in a lower dimensional subspace, the dimension of this subspace.}
  \item{hyperplane}{If the data are lying in a lower dimensional subspace, a direction orthogonal to this subspace.}
}
\references{
Ruts I., Rousseeuw P.J. (1996). Computing depth contours of bivariate point clouds. \emph{Computational Statistics & Data Analysis}, \bold{23}, 153--168.

}

\seealso{\code{\link{plotContours}}, \code{\link{bagdistance}}}


\author{P. Segaert based on Fortran code by  P.J. Rousseeuw, I. Ruts and A. Struyf}

\examples{

# Compute and plot some halfspace depth contours of a two-dimensional dataset. 
# The returned object is a ggplot2 object that may be edited 
# using standard ggplot2 commands.

# One may consider different depth functions such as projection depth 
# by changing the input parameter 'type'.
# By default the halfspace depth is used.
data(bloodfat)
Result <- depthContour(x = bloodfat,
                       alpha = c(0.03, 0.125, 0.25))
plotContours(x = bloodfat, depthContour = Result)


# Other options are projection depth, skewness-adjusted projection depth
# and directional projection depth
# they can be used by specifying type to be
# "projdepth", "sprojdepth" or "dprojdepth" respectively.
# When there is skewness in the data projection depth
# is less appropriate. 

Result <- depthContour(x = bloodfat,
                       alpha = c(0.25, 0.35, 0.45),
                       type = "projdepth")
plotContours(x = bloodfat, depthContour = Result)

# The skewness-adjusted projection depth and directional projection depth
# better reflect the skewness in the data.
Result <- depthContour(x = bloodfat,
                       alpha = c(0.35, 0.45, 0.55),
                       type = "sprojdepth")
plotContours(x = bloodfat, depthContour = Result)

Result <- depthContour(x = bloodfat,
                       alpha = c(0.25, 0.35, 0.45),
                       type = "dprojdepth")
plotContours(x = bloodfat, depthContour = Result)

}
\keyword{multivariate}
