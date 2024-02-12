fdlen <- c(
1, 6, 1, 1, 2, 
2, 2, 1, 1, 3,
1, 1, 2, 1, 
1, 1, 2,
1, 1, 1, 1,
1, 1, 1,
# 37
2, 2, 2,
1, 1,
2, 
2, 
1, 
1, 1, 2, 1, 1, 1, 2,
1, 1, 1, 1, 1, 1, 1,
2, 2, 2, 1, 1, 2, 2, 1,
1, 2,
2, 2,
# additional variables for 1970- onwards
1, 2, 2, 2,
3, 2, 
2, 2, 3, 2, 34
)
vnames <- c(
"y4",  # 4th digit of YYYY
"cert",  # certificate number
"region",  
"division",  
"state",  
"month",  
"day",  
"dow",  # day of week
"ceretype",  # ceremony type: 1=civil, 2=religious, 9=not stated
"w",  # weight of record
## groom
"res1.g",  #resident status 1: 1=in state of marriage, 2=other state or outside US, 3=not stated
"res2.g",  #resident status 2: 1=in state of marriage, 2=adjoining state, 3=other state or outside US, 4=not stated
"resstate.g",  # state of residence
"bl1.g",  # blank
"nat1.g",  # nativity status 1: 1=born in state of residency, 2=born in adjoining state, 3=born other state or outside US, 4=not stated
"nat2.g",  
"natstate.g",  
"race.g",  
"racedet.g",  
"mnum.g",  
"mnumdet.g",  
"pmstatus1.g",  
"pmstatus2.g",  
"pmstatusdet.g",  
"dom.g",  
"doy.g",  
"agem.g",  
"agem1.g",  
"agem2.g",  
"agem3.g",  
"agem4.g",  
"agem5.g",  
## bride
"res1.b",  
"res2.b",  
"resstate.b",  
"bl1.b",  
"nat1.b",  
"nat2.b",  
"natstate.b",  
"race.b",  
"racedet.b",  
"mnum.b",  
"mnumdet.b",  
"pmstatus1.b",  
"pmstatus2.b",  
"pmstatusdet.b",  
"dom.b",  
"doy.b",  
"agem.b",  
"agem1.b",  
"agem2.b",  
"agem3.b",  
"agem4.b",  
"agem5.b",  
"mra",  
"edu.g",  
"edu.b",  
"bl2",  
"agediff",  
"agediffy",  
## groom
"prevmon.g",  
"prevyr.g",  
"int.g",  
"int17.g",  
## bride
"prevmon.b",  
"prevyr.b",  
"int.b",  
"int17.b",  
"bl3"
)

