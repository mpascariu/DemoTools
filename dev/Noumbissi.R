
# Author: tim
###############################################################################

#' calculate Noubmissi's digit heaping index
#' 
#' @description this method compares single terminal digit numerators to denominators 
#' consisting in 5-year age groups centered on the digit in question. As seen in Spoorenberg (2007)

#' @param Value a vector of demographic counts by single age
#' @param Age a vector of ages corresponding to the lower integer bound of the counts
#' @param ageMin the lowest age included in calcs. Default 20
#' @param ageMax the upper age bound used for calcs. Default 65
#' @param digit which terminal digit do we calculate for?
#' 
#' @return the index value 

#' @export

Noumbissi <- function(Value, Age, ageMin = 20, ageMax = 65, digit = 0){
	stopifnot(length(Age) == length(Value))
	stopifnot(length(digit) == 1)
	
	numi   <- Age >= ageMin & Age <= ageMax & Age %% 10 %in% digit
	denomi <- shift.vector(numi,-2) | 
              shift.vector(numi,-1) |
			  numi |
			  shift.vector(numi,1) |
			  shift.vector(numi,2)
	5 * sum(Value[numi]) / sum(Value[denomi])
}

#Value <- c(80626,95823,104315,115813,100796,105086,97266,116328,
#75984,89982,95525,56973,78767,65672,53438,85014,
#47600,64363,42195,42262,73221,30080,34391,29072,
#20531,66171,24029,44227,24128,23599,82088,16454,
#22628,17108,12531,57325,17220,28425,16206,17532,
#65976,11593,15828,13541,8133,44696,11165,18543,
#12614,12041,55798,9324,10772,10453,6773,28358,
#9916,13348,8039,7583,42470,5288,5317,6582,
#361,17949,3650,5873,3279,3336,27368,1965,
#2495,2319,1335,12022,1401,1668,1360,1185,
#9167,424,568,462,282,6206,343,409,333,291,4137,133,169,157,89,2068,68,81,66,57)
#Age <- 0:99
#Noumbissi(Value, Age, digit = 0) # 2.32
#Noumbissi(Value, Age, digit = 1) # 0.55
#Noumbissi(Value, Age, digit = 2) # 0.73
#Noumbissi(Value, Age, digit = 3) # 0.76
#Noumbissi(Value, Age, digit = 4) # 0.49
#Noumbissi(Value, Age, digit = 5) # 2.08
#Noumbissi(Value, Age, digit = 6) # 0.66
#Noumbissi(Value, Age, digit = 7) # 1.08  7 looks good!
#Noumbissi(Value, Age, digit = 8) # 0.57
#Noumbissi(Value, Age, digit = 9) # 0.59
