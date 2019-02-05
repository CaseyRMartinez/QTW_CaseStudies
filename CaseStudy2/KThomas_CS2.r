
# pretty boxplot
# install.packages('ggthemes')
library(ggthemes)
library(ggplot2)

load('/home/kyle/Documents/thomaskh522@gmail.com/SMU/Quant the World/RTLS_CaseStudy/CaseStudy2/data/Cleaned_Data/cbMen.rda')
# load('C:/Users/casey/Dropbox/SMU_DataScience/MSDS_7333_QuantifyingTheWorld/QTW_CaseStudies/CaseStudy2/data/Cleaned_Data/cbMen.rda')

# Lets make box plots of age across all 14 years of the race
head(cbMen)

library(dplyr)
cbMen$year = as.factor(cbMen$year)
ages = group_by(cbMen, year)
ageSummary = summarize(ages, ageMean = mean(age, na.rm = TRUE),ageMedian = median(age, na.rm = TRUE), count=n())
ageSummary

# plot(ageSummary$ageMean ~ ageSummary$year, type="l", lwd = 2,
#      xlab = "Years", ylab = "Number of Runners")
# par(oldPar)
# dev.off()


ggplot(ageSummary, aes(x=year, y=ageMean, group=1)) +
geom_line() +
geom_point() + 
ggtitle("Mean Age by Year") +
xlab("Year") +
ylab("Age") + 
# theme_fivethirtyeight() +
theme_economist() + 
theme(plot.title = element_text(hjust = 0.5))



# plot(ageSummary$ageMean ~ ageSummary$year, type="l", lwd = 2,
#      xlab = "Years", ylab = "Number of Runners")
# par(oldPar)
# dev.off()


ggplot(ageSummary, aes(x=year, y=count, group=1)) + 
geom_col() +
geom_line(color='red') +
geom_point(color='red') +
ggtitle("Count by Year") +
xlab("Year") +
ylab("Count") + 
# theme_fivethirtyeight() +
theme_economist() + 
theme(plot.title = element_text(hjust = 0.5))



linearMod <- lm(count ~ as.numeric(year), data=ageSummary)  # build linear regression model on full data
print(linearMod)

# value.ts = ts(Value, frequency=12, start=c(2000,1), end=c(2006,12)) #create subset by date and make it a time series
value.ts <- ts(as.numeric(ageSummary$ageMean), start = 1999)
# plot(value.ts)

# install.packages('changepoint')
library(changepoint)
mvalue = cpt.meanvar(value.ts, method='PELT')
cpts(mvalue)
plot(mvalue, type="b", xlab = "Years", ylab = "Mean Age", main='Change Point Analysis')

# value.ts = ts(Value, frequency=12, start=c(2000,1), end=c(2006,12)) #create subset by date and make it a time series
value.ts <- ts(as.numeric(ageSummary$count), start = 1999)
# plot(value.ts)

# install.packages('changepoint')
library(changepoint)
mvalue = cpt.meanvar(value.ts, method='PELT')
cpts(mvalue)
plot(mvalue, type="b", xlab = "Years", ylab = "Count", main='Change Point Analysis')


ggplot(cbMen, aes(x=as.factor(year), y=age)) + 
geom_boxplot() + 
ggtitle("Men's Age Distribution by Year") +
xlab("Year") +
ylab("Age") + 
# theme_fivethirtyeight() +
theme_economist() + 
theme(plot.title = element_text(hjust = 0.5))



y = quantile(cbMen$age[!is.na(cbMen$age)], c(0.25, 0.75))
x = qnorm(c(0.25, 0.75))

slope = diff(y)/diff(x)
int = y[1L] - slope * x[1L]


p = qplot(sample=age, data=cbMen, color=year) + 
geom_abline(slope = slope, intercept = int) + 
ggtitle("QQ Plot of Men's Age") +
xlab("Theoretical Quantiles") +
ylab("Sample Quantiles") +
theme_economist() + 
theme(plot.title = element_text(hjust = 0.5))
p

y = quantile(cbMen$age[!is.na(cbMen$age)], c(0.25, 0.75))
x = qnorm(c(0.25, 0.75))

slope = diff(y)/diff(x)
int = y[1L] - slope * x[1L]
Year = as.factor(cbMen$year)

p = qplot(sample=age, data=cbMen, color=Year) + 
geom_abline(slope = slope, intercept = int) + 
ggtitle("QQ Plot of Men's Age by Year") +
xlab("Theoretical Quantiles") +
ylab("Sample Quantiles") +
theme_economist() + 
theme(plot.title = element_text(hjust = 0.5))

p

# Make a pretty plot
y = quantile(cbMen$age[!is.na(cbMen$age)], c(0.25, 0.75))
x = qnorm(c(0.25, 0.75))

slope = diff(y)/diff(x)
int = y[1L] - slope * x[1L]


p = qplot(sample=age, data=cbMen, color=as.factor(year)) + 
geom_abline(slope = slope, intercept = int) +
ggtitle("QQ Plot of Men's Age by Year") +
xlab("Theoretical Quantiles") +
ylab("Sample Quantiles") +
theme(plot.title = element_text(hjust = 0.5))

# theme_economist()

p

# Make a pretty plot
y = quantile(cbMen$age[!is.na(cbMen$age)], c(0.25, 0.75))
x = qnorm(c(0.25, 0.75))

slope = diff(y)/diff(x)
int = y[1L] - slope * x[1L]


p = qplot(sample=year, data=cbMen, color=as.factor(age)) + 
geom_abline(slope = slope, intercept = int) +
ggtitle("QQ Plot of Men's Age by Year") +
xlab("Theoretical Quantiles") +
ylab("Sample Quantiles") +
theme(plot.title = element_text(hjust = 0.5))

# theme_economist()

p

mean_age = mean(cbMen$age, na.rm = TRUE)

p = ggplot(cbMen, aes(x=age)) + 
geom_density() + 
geom_vline(aes(xintercept=mean_age), color="red", linetype="dashed", size=1) + 
ggtitle("Density Plot of Men's Age") + 
xlab("Age") + 
ylab("Density") + 
theme_economist() +
theme(plot.title = element_text(hjust = 0.5))

p

Year = as.factor(cbMen$year)

p = ggplot(cbMen, aes(age, color=Year)) + 
geom_density() + 
ggtitle("Density Plot of Men's Age by Year") + 
xlab("Age") + 
ylab("Density") + 
labs(color="Year") +
theme_economist() +
theme(plot.title = element_text(hjust = 0.5))

p

p = ggplot(cbMen, aes(age, fill=as.factor(year))) + 
geom_density(alpha=0.25) + 
ggtitle("Density Plot of Men's Age by Year") + 
xlab("Age") + 
ylab("Density") + 
theme_economist() +
theme(plot.title = element_text(hjust = 0.5))

p

Year = as.factor(cbMen$year)

res.aov <- aov(age ~ Year, data = cbMen)

summary(res.aov)

TukeyHSD(res.aov, "Year")

plot(TukeyHSD(res.aov))


cbMen

# Plot pairwise TukeyHSD comparisons and color by significance level
# tky = as.data.frame(TukeyHSD(res.aov, "Year"))
tky = as.data.frame(TukeyHSD(res.aov)$Year)
tky$pair = rownames(tky)

options(repr.plot.width=8, repr.plot.height=12)

# Plot pairwise TukeyHSD comparisons and color by significance level
# code borrowed from: https://stackoverflow.com/questions/33644034/how-to-visualize-pairwise-comparisons-with-ggplot2
ggplot(tky, aes(colour=cut(`p adj`, c(0, 0.01, 0.05, 1), 
                           label=c("p<0.01","p<0.05", "Non-Significant")))) +
  geom_hline(yintercept=0, lty="11", colour="grey30") +
  geom_errorbar(aes(pair, ymin=lwr, ymax=upr), width=0.2) +
  geom_point(aes(pair, diff)) +
  labs(colour="") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  theme(legend.position = "none") + 
# scale_x_discrete(labels = abbreviate)
  coord_flip() 
#   theme_economist()



from IPython.core.display import display, HTML
display(HTML("<style>.container { width:100% !important; }</style>"))

# How many europeans are in the dataset?
eu = "Austria
Belgium
Bulgaria
Croatia
Cyprus
Czech Republic
Denmark
Estonia
Finland
France
Germany
Greece
Hungary
Ireland
Italy
Latvia
Lithuania
Luxembourg
Malta
Netherlands
Poland
Portugal
Romania
Slovakia
Slovenia
Spain
Sweden
United Kingdom"

eu_s = strsplit(eu, "\n")
eu_s


cbMen[cbMen$home  "VA",]

unique(cbMen$home)
