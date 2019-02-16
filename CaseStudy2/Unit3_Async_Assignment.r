
# Unit 3 Assignment
library(data.table)
resData = fread('http://www.users.miamioh.edu/hughesmr/sta333/respiratory.txt')

plot(resData)

loess10 = loess(rate~age, data=resData, span=0.1)
loess25 = loess(rate~age, data=resData, span=0.25)
loess50 = loess(rate~age, data=resData, span=0.50)

s10 = predict(loess10)
s25 = predict(loess25)
s50 = predict(loess50)

plot(resData)
lines(s10, x=resData$age, col='red')
lines(s25, x=resData$age, col='blue')
lines(s50, x=resData$age, col='green')
legend(25, 75, legend = c('Span 10', 'Span 25', 'Span 50'), col=c('red', 'blue', 'green'), lty=1)
