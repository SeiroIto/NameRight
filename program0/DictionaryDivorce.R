fdlen <- c(
1, 6, 2, 1,
1, 2, 1, 1,
2, 2, 2, 1, 2, 
1, 1, 2,
2, 2,
2, 1, 2,
# 38
1, 1, 2,
2, 1, 1, 2, 2,
2, 2, 1,
2, 1, 1,
1, 1, 1,
# 62
1, 2, 1, 1, 2, 2,
2, 2, 1, 2, 1, 1, 1,
1, 1, 1, 1, 1,
# additional variables for 1970- onwards
2, 2, 2,
# 92
1, 1, 1,
1, 2,
2, 3, 2,
3, 2,
2, 2,
2, 2
)
vnames <- c(
"y4",  # 4th digit of YYYY
"cert",  # certificate number
"state", 
"region",  
"division",  
"month",  
"plaintiff", 
"decree", 
"ground1", "ground2", "ground3", 
"bl1", 
"numchild", "numchild1", "numchild2",
"marmonth", "maryear", 
"duryear", "duryear1", "duryear2", 
"marstate", 
"marregion", 
"status", "w",  
## husband
"resstate.g",  # state of residence
"resregion.g", 
"res.g",  #resident status
"dobm.g",  
"doby.g",  
"aged.g",  "aged1.g",  "aged2.g",  
"agem.g",  "agem1.g",  
"race.g", "race1.g", "race2.g", 
"mnum.g", "mnum1.g",  
## wife
"resstate.b",  # state of residence
"resregion.b", 
"res.b",  #resident status
"dobm.b",  "doby.b",  
"aged.b",  "aged1.b",  "aged2.b",  "agem.b",  "agem1.b",  
"race.b", "race1.b", "race2.b", 
"mnum.b",  "mnum1.b",  
"placem3", "placem4", 
# additional variables for 1970- onwards
"sepmon", "sepyear", 
"numchildatsep", 
"prevdeath.g", "prevdiv.g", "prevdeath.b", "prevdiv.b", 
"edu.g",  "edu.b",  
"intsepmon", "intsep", 
"intdecmon", "intdec", 
"agesep.g", "agesep1.g", 
"agesep.b", "agesep1.b"
)

