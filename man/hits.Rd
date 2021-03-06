\name{hits}
\alias{hits}
\title{Creating a fixed effect matrix with significant GWAS markers}
\description{
This function was designed to create a design matrix with the significant markers found by a GWAS analysis in order to use it in the GBLUP or genomic prediction analysis to increase the predction accuracy. The method is based on sevral papers suggesting that the use of signifant markers associated to the causal variant may increase the prediction accuracy under the GBLUP framework. For example, Bernardo (2014), Gianola et al. (2014) Abdollahi Arpanahi et al. (2015) papers were using the top 10-20 GWAS hit markers and using them as fixed effect, increasing the prediction accuracy of the genomic prediction model. This phenomena has been explained arguing that the mixed model shrinks too much the effect of markers with big effects and therefore using such markers as fixed effects causes a dramatic increase in the prediction accuracy of a model using them. It has to be noted that for traits of low h2 or with a high number of QTL's with small effects this method doesn't help but actually has a reducing effect in the prediction accuracy.
}
\usage{
hits(gwasm, nmar=10, threshold=1, pick=FALSE, method="cluster", only.mark=FALSE,
    plotting=TRUE)
}
\arguments{
  \item{gwasm}{a GWAS model fitted using mmer}
  \item{nmar}{the number of GWAS hits (markers) to be used for designing the incidence matrix. It finds the markers with maximum significance value and uses them to create the design matrix. The default is the top 10 markers.}
  \item{threshold}{a numeric value indicating the minimum significance value to be used for finding the significant markers. the dedault is 1.}
  \item{pick}{a TRUE/FALSE value indicating if the user prefers to pick the peaks by himself. The default is FALSE leaving the peak selection to one of the two methods available. If set to TRUE R will allow the user to pick the peaks by cliking over the peaks and typing 'Esc' when the user is done selecting the peaks.}
  \item{method}{one of the two methods available; "cluster" performs peak selection by making clusters using k-means (random clusters), whereas "maximum" takes the markers with highest log p.values and select those for designing the model matrix.}
  \item{only.mark}{a TRUE/FALSE statement indicating if the only output should be the marker names or the incidence matrix. By default it returns the incidence matrix but if turned to TRUE will return only the marker names. Useful when want to identify significant markers in different populations.}
  \item{plotting}{a TRUE/FALSE statement indicating if the program should plot the GWAS showing which markers were selected.}

}

\value{
If all parameters are correctly indicated the program will return:
\describe{

\item{$X2}{a design matrix with individuals in rows and markers in columns to be used for the GBLUP model based on the GWAS model provided.}

}
}
\references{

Bernardo, Rex. 2014. Genomewide selection when major genes are known. Crop Science 54.1:68-75.

Gianola, Daniel, et al. 2014. Enhancing genome-enabled prediction by bagging genomic BLUP. PLoS One 9.4: e91693.

Abdollahi Arpanahi R, Morota G, Valente BD, Kranis A, Rosa GJM, Gianola D. 2015. Assessment of hitsging GBLUP for whole genome prediction of broiler chicken traits. Journal of Animal Breeding and Genetics 132:218-228.

Covarrubias-Pazaran G (2016) Genome assisted prediction of quantitative traits using the R package sommer. PLoS ONE 11(6): doi:10.1371/journal.pone.0156744 

}
\author{
Giovanny Covarrubias-Pazaran
}
\examples{
####=========================================####
#### For CRAN time limitations most lines in the 
#### examples are silenced with a single '#' mark, 
#### remove them and run the examples
###=========================================####
data(CPdata)

####=========================================####
#### convert markers to numeric format
####=========================================####
## fit a model including additive and dominance effects
y <- CPpheno$color
Za <- diag(length(y))
A <- A.mat(CPgeno) # additive relationship matrix

####=========================================####
#### compare prediction accuracies between
#### GBLUP and hits GBLUP 
####=========================================####
set.seed(1234)
y.trn <- y # for prediction accuracy
ww <- sample(c(1:dim(Za)[1]),72) # delete data for one fifth of the population
y.trn[ww] <- NA

####=========================================####
#### identify major genes and create the hit matrix
####=========================================####

#ETA.A <- list(list(Z=Za,K=A))
#ans.GWAS <- mmer(Y=y.trn, Z=ETA.A, W=CPgeno)
#summary(ans.GWAS)

####=========================================####
#### run the hits function to design the matrix
#### for top GWAS hits
####=========================================####

#X1 <- hits(ans.GWAS);head(X1); dim(X1)

#ETA.A <- list(list(Z=Za,K=A))
#ans.A <- mmer(Y=y.trn, Z=ETA.A) # GBLUP
#ans.AF <- mmer(Y=y.trn, X=X1, Z=ETA.A) # hitsging-GBLUP
#cor(ans.A$fitted.y[ww], y[ww], use="pairwise.complete.obs") # GBLUP
#cor(ans.AF$fitted.y[ww], y[ww], use="pairwise.complete.obs") # hitsging-GBLUP
#### little increase in prediction accuracy

}
\seealso{The core functions of the package \code{\link{mmer}} and \code{\link{mmer2}}}