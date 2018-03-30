load("The_DonaldReadability.RData")
load("ResisttReadability.RData")
load("SandersForPresidentReadability.RData")
load("HillaryCintonReadability.RData")

# This script is used to calculate the averages of the readability data for the four
# subreddits since they had to be processed in chunks due to limitations in the
# package koRpus

# This index is just the names of all the different readability measures used.
index = readability.The_Donald[,1]

#################################################
# The_Donald

The_Donald.raw = readability.The_Donald[,seq(3,125,by=5)]
raw = vector()
for(i in 1:25){
  raw = cbind(raw,raw = as.numeric(The_Donald.raw[,i]))
}
avg.raw = apply(raw, 1, mean)

The_Donald.grade = readability.The_Donald[,seq(4,125,by=5)]
grade = vector()
for(i in 1:25){
  grade = cbind(grade,grade = as.numeric(The_Donald.grade[,i]))
}
avg.grade = apply(grade, 1, mean)

The_Donald.Readability = cbind(index = index, raw = avg.raw, grade = avg.grade)

# HillaryClinton

HillaryClinton.raw = readability.HillaryClinton[,seq(3,30,by=5)]
raw = vector()
for(i in 1:6){
  raw = cbind(raw,raw = as.numeric(HillaryClinton.raw[,i]))
}
avg.raw = apply(raw, 1, mean)

HillaryClinton.grade = readability.HillaryClinton[,seq(4,30,by=5)]
grade = vector()
for(i in 1:6){
  grade = cbind(grade,grade = as.numeric(HillaryClinton.grade[,i]))
}
avg.grade = apply(grade, 1, mean)

HillaryClinton.Readability = cbind(index = index, raw = avg.raw, grade = avg.grade)


# SandersForPresident

SandersForPresident.raw = readability.SandersForPresident[,seq(3,130,by=5)]
raw = vector()
for(i in 1:26){
  raw = cbind(raw,raw = as.numeric(SandersForPresident.raw[,i]))
}
avg.raw = apply(raw, 1, mean)

SandersForPresident.grade = readability.SandersForPresident[,seq(4,130,by=5)]
grade = vector()
for(i in 1:26){
  grade = cbind(grade,grade = as.numeric(SandersForPresident.grade[,i]))
}
avg.grade = apply(grade, 1, mean)

SandersForPresident.Readability = cbind(index = index, raw = avg.raw, grade = avg.grade)

# Resist

Resist.raw = readability.Resist[,seq(3,55,by=5)]
raw = vector()
for(i in 1:11){
  raw = cbind(raw,raw = as.numeric(Resist.raw[,i]))
}
avg.raw = apply(raw, 1, mean)

Resist.grade = readability.Resist[,seq(4,55,by=5)]
grade = vector()
for(i in 1:11){
  grade = cbind(grade,grade = as.numeric(Resist.grade[,i]))
}
avg.grade = apply(grade, 1, mean)

Resist.Readability = cbind(index = index, raw = avg.raw, grade = avg.grade)

######################################################################################

# Clear Unnessary objects and save needed ones to be used by other scriptss
rm(list=setdiff(ls(), c("Resist.Readability","SandersForPresident.Readability","HillaryClinton.Readability","The_Donald.Readability")))
save.image("SubredditsReadability.RData")
