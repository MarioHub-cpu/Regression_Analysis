### Regression Model Script

# The regressionModel script is used to define and hypothesize 
# different regression models to evaluate the relationship 
# between the dependent and independent variables that have been
# identified in the descriptiveAnalysis script.

results <- "~/Desktop/Regression_Analysis/results/scatterplots/"

## MULTIPLE REGRESSION MODEL

# Given the elimination from our dataset of the x7_PixDensity variable,
# let us establish a multiple regression model without any further assumption.

completeModel <- lm(processedData$y_VideoQuality ~ processedData$x1_ISO + 
     processedData$x2_FRatio + processedData$x3_TIME+ 
     processedData$x4_MP + processedData$x5_CROP + processedData$x6_FOCAL)

## ALTERNATIVE REGRESSION MODEL

# As shown in the "results/Polynomial_Regression.txt" document
# the Training Set, and the Processed - Data Set both presents a statistically 
# relevant correlation between the response variable and the predictors: x1_ISO, x2_FRatio ,
# x3_TIME and x5_CROP. We can expect those predictors having a strong 
# influence on y_VideoQuality given those high significance levels.

# Focus - scatter plot of the most relevant predictors
# y_VideoQuality <-> x1_ISO
png(filename = paste0(results, "scatter-x1-y.png"))
plot(dataRaw$x1_ISO, dataRaw$y_VideoQuality, main = "Video Quality - ISO",xlab='x1_ISO',ylab='y_VideoQuality')
dev.off()
# y_VideoQuality <-> x2_FRatio
png(filename = paste0(results, "scatter-x2-y.png"))
plot(dataRaw$x2_FRatio, dataRaw$y_VideoQuality, main = "Video Quality - Focal Ratio",xlab='x2_FRatio',ylab='y_VideoQuality')
dev.off()
# y_VideoQuality <-> x3_TIME
png(filename = paste0(results, "scatter-x3-y.png"))
plot(dataRaw$x3_TIME, dataRaw$y_VideoQuality, main = "Video Quality - Time",xlab='x3_TIME',ylab='y_VideoQuality')
dev.off()
# y_VideoQuality <-> x5_CROP
png(filename = paste0(results, "scatter-x3-y.png"))
plot(dataRaw$x5_CROP, dataRaw$y_VideoQuality, main = "Video Quality - Crop Factor",xlab='x5_CROP',ylab='y_VideoQuality')
dev.off()


# Formulation of an alternative model containing just the listed predictors

alternativeModel1 <- lm(processedData$y_VideoQuality ~ processedData$x1_ISO + processedData$x2_FRatio 
                        + processedData$x3_TIME + processedData$x5_CROP)
print(summary(alternativeModel1))

alternativeModel2 <- lm(processedData$y_VideoQuality ~ poly(processedData$x1_ISO,2) + poly(processedData$x2_FRatio,2) 
                        + poly(processedData$x3_TIME,2) + poly(processedData$x5_CROP,1))
print(summary(alternativeModel2))

