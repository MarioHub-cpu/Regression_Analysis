### Descriptive Analysis Script

# The descriptiveAnalysis script is used to 
# analyze all the variables in the training set using
# descriptive statistics methods, aiming to obtain
# crucial characteristic quantities about the dependent 
# variable and the predictor variables.

# A graphical evaluation first will contribute to our analysis
# by exposing quantiles and outliers; a mathematical evaluation 
# then will provide precious informations about mean and variance.

# The following script will be useful and necessary to the correlation analysis phase.

# directory containing every relevant result
resultsBox <- "~/Desktop/Regression_Analysis/results/boxplots/"
resultsHist <- "~/Desktop/Regression_Analysis/results/histograms/"
results <- "~/Desktop/Regression_Analysis/results/"

# Persistence Logic

sDS <- capture.output(summary(dataRaw))
summaryDataSet <- c("Summary of the non-processed Data Set:\n",
                    sDS, "\n",
                    "Dimension: ", dimension)
writeLines(summaryDataSet, "results/CharacterizedDataSet.txt")

## GRAPHICAL EVALUATION

# Histogram of Every Variable
for (i in 1:8){
  png(filename = paste0(resultsHist, "histogram_", names(dataRaw)[i], ".png"))
  hist(dataRaw[, i], 
       main = names(dataRaw)[i],
       xlab = names(dataRaw)[i],
       col = "blue",
       border = "black"
  )
  dev.off()
}

# General View of each Variable's Box-plot
png(filename = paste0(resultsBox, "boxplot_all_variables.png"))
boxplot(dataRaw)
dev.off()

# Box-plot of every Variable in search for eventual Outliers
for (i in 1:8){
  png(filename = paste0(resultsBox, "boxplot_", names(dataRaw)[i], ".png"))
  boxplot(dataRaw[, i], main = names(dataRaw)[i])
  dev.off()
}

# Q-Q plot of the response variable (y_VideoQuality) 
# to visually assess its normality. This check can help evaluate whether
# the residuals from the regression model follow a normal distribution.
# Further and more formal normality tests will be conducted later in "decision.R".
png(filename = paste0(results, "Q-Q_Plot_y.png"))
qqnorm(dataRaw$y_VideoQuality, main = "Q-Q plot Response Variable")
qqline(dataRaw$y_VideoQuality, col = "red")
dev.off()

## ANALYTIC EVALUATION 

# Shapiro - Wilks test, checking for normal distribution

shapY <- (shapiro.test(dataRaw$y_VideoQuality))
# p-value = 0.3124 > 0.05 --> y_VideoQuality is 
# distributed as a Normal random variable

shapX1 <- shapiro.test(dataRaw$x1_ISO)
# p-value too low --> x1_ISO is not
# distributed as a Normal random variable

shapX2 <- shapiro.test(dataRaw$x2_FRatio)
# p-value too low --> x2_FRatio is not
# distributed as a Normal random variable

shapX3 <- shapiro.test(dataRaw$x3_TIME)
# p-value too low --> x3_TIME is not
# distributed as a Normal random variable

shapX4 <- shapiro.test(dataRaw$x4_MP)
# p-value too low --> x4_MP is not
# distributed as a Normal random variable

shapX5 <- shapiro.test(dataRaw$x5_CROP)
# p-value too low --> x5_CROP is not
# distributed as a Normal random variable

shapX6 <- shapiro.test(dataRaw$x6_FOCAL)
# p-value too low --> x6_FOCAL is not
# distributed as a Normal random variable

shapX7 <- shapiro.test(dataRaw$x7_PixDensity)
# p-value too low --> x7_PixDensity is not
# distributed as a Normal random variable

# Persistence Logic
shapOutY <- capture.output(print(shapY))
shapOutX1 <- capture.output(print(shapX1))
shapOutX2 <- capture.output(print(shapX2))
shapOutX3 <- capture.output(print(shapX3))
shapOutX4 <- capture.output(print(shapX4))
shapOutX5 <- capture.output(print(shapX5))
shapOutX6 <- capture.output(print(shapX6))
shapOutX7 <- capture.output(print(shapX7))
shapOut <- c("Shapiro-Wilk test for each dataRaw variable:\n",
             shapOutY, "p-value > alpha=0.05, y_VideoQuality is distributed as a Normal random variable" , "\n",
             shapOutX1,"p-value < alpha=0.05, x1_ISO is not distributed as a Normal random variable" ,"\n",
             shapOutX2, "p-value < alpha=0.05, x2_FRatio is not distributed as a Normal random variable" , "\n",
             shapOutX3, "p-value < alpha=0.05, x3_TIME is not distributed as a Normal random variable" ,"\n",
             shapOutX4, "p-value < alpha=0.05, x4_MP is not distributed as a Normal random variable" ,"\n",
             shapOutX5, "p-value < alpha=0.05, x5_CROP is not distributed as a Normal random variable" ,"\n",
             shapOutX6, "p-value < alpha=0.05, x6_FOCAL is not distributed as a Normal random variable" ,"\n",
             shapOutX7, "p-value < alpha=0.05, x7_PixDensity is not distributed as a Normal random variable")
writeLines(shapOut, "results/Shapiro-Wilk.txt")

# Summary of each Variable
cat("\nDescriptive statistics for each variable:")
for (i in 1:8){
  cat("\nVariable: ", names(dataRaw)[i])
  cat("\nMean: ", mean(dataRaw[, i]))
  cat("\nVariance: ", var(dataRaw[, i]))
  cat("\nStandard Deviation: ", sd(dataRaw[, i]))
  cat("\nMin: ", min(dataRaw[, i]))
  cat("\nMax: ", max(dataRaw[, i]))
  cat("\nQuantiles (25%, 50%, 75%): ", quantile(dataRaw[, i], probs = c(0.25, 0.5, 0.75)))
  cat("\nInterquartile Range (IQR): ", IQR(dataRaw[, i]))
  cat("\n\n")
}
