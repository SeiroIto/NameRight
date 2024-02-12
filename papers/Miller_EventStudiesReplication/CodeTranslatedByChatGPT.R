#### A1-A2 ####

library(data.table)

# Set seed for reproducibility
set.seed(101)

# NxT DiD data structure
data <- data.table(i = 1:100)
data[, treated := i > 50]  # Half of units treated
data[treated == 1, Ei := 11]

# Expand to 20 time periods
data <- data[, .(i = rep(i, each = 20), treated = rep(treated, each = 20), Ei = rep(Ei, each = 20))]
## 
data[, t := 1:.N, by = i]
# Sort by unit and time
setkey(data, i, t)

# Make variables that determine the DGP
data[, D := (t == Ei)]  # The event "pulse"
data[, etime := (t - Ei)]  # Event time

# Graph 4
data[treated == 0, Ei := 16]
data[treated == 1 & i %between% c(51, 61), Ei := 5]
data[treated == 1 & i %between% c(62, 68), Ei := 6]
data[treated == 1 & i %between% c(69, 70), Ei := 7]
data[treated == 1 & i %between% c(71, 75), Ei := 10]
data[treated == 1 & i %between% c(76, 90), Ei := 11]
data[treated == 1 & i >= 91, Ei := 12]

# Graph 5
data[treated == 1, Ei := 5]
data[treated == 1 & i %between% c(1, 20), Ei := 6]
data[treated == 1 & i %between% c(21, 32), Ei := 7]
data[treated == 1 & i %between% c(33, 37), Ei := 10]
data[treated == 1 & i %between% c(38, 58), Ei := 11]
data[treated == 1 & i %between% c(59, 64), Ei := 12]
data[treated == 1 & i > 90, Ei := 15]


library(data.table)
library(ggplot2)
library(ggpubr)

# Continue from where the previous code left off

# Graph 5 - Continued
data[treated == 1, Ei := 5]
data[treated == 1 & i %between% c(1, 20), Ei := 6]
data[treated == 1 & i %between% c(21, 32), Ei := 7]
data[treated == 1 & i %between% c(33, 37), Ei := 10]
data[treated == 1 & i %between% c(38, 58), Ei := 11]
data[treated == 1 & i %between% c(59, 64), Ei := 12]
data[treated == 1 & i > 90, Ei := 15]


#### A3 ####


library(data.table)
library(ggplot2)

# Set seed
set.seed(101)

# Define function to generate data
gendata <- function(ctrl, trends) {
  # Your gendata logic here
}

# Define function to count variables
count_vars <- function(vars) {
  X <- as.matrix(data.table::data.table(vars))
  mycols <- ncol(X)
  myrank <- rank(X)
  gap <- mycols - myrank
  return(c(mycols, myrank, gap))
}

# Define function runme
runme <- function(ctrl, trends) {
  # Call gendata function
  data <- gendata(ctrl, trends)
  # Loop to generate D variables
  for (i in 0:20) {
    data[, paste0("D_p", i) := (etime == i)]
    data[, paste0("D_m", i) := (etime == -i)]
    # Drop variables if mean is 0
    if (mean(data[, paste0("D_p", i)]) == 0) {
      data[, (paste0("D_p", i)) := NULL]
    }
    if (mean(data[, paste0("D_m", i)]) == 0) {
      data[, (paste0("D_m", i)) := NULL]
    }
  }
  # Drop D_m0
  data[, D_m0 := NULL]
  # Generate unittype variable and tabulate it
  data[, unittype := .GRP, by = Ei]
  udum <- table(data$unittype)
  # Tabulate t variable
  tdum <- table(data$t)
  # Count variables using Mata
  vars <- c(paste0("D_", 0:20), paste0("udum", 1:length(udum)), paste0("tdum", 1:length(tdum)))
  count <- count_vars(data[, ..vars])
  # Print results
  cat("ctrl trends", rep(" ", 20 - nchar("ctrl trends")), ctrl, rep(" ", 5 - nchar(ctrl)),
      trends, rep(" ", 10 - nchar(trends)),
      count[1], rep(" ", 5 - nchar(count[1])),
      count[2], rep(" ", 10 - nchar(count[2])),
      count[3], "\n")
}

# Define gendata function
gendata <- function(ctrl, trends) {
  # Your gendata logic here
  return(data)
}

# Define bigone function
bigone <- function() {
  # Your bigone logic here
}

# Run the program
runme("10 11", 0, 0)

for (i in 4:16) {
  runme(paste0("4 16 ", i), 0, 0)
  rest_m3_i <- count_vars(runme(paste0("4 16 ", i, " 10"), 0, 0))[3] - 2
  runme(paste0("4 16 ", i, " 10"), 0, 0)
  rest_m4_i <- count_vars(runme(paste0("4 16 ", i, " 10"), 0, 0))[3] - 2
}

data <- data.table::data.table(
  obs = 1:7,
  Ei = 4:10,
  units3 = c(rep(NA, 3), rest_m3_i, rep(NA, 3)),
  units4 = c(rep(NA, 3), rest_m4_i, rep(NA, 3))
)

data$E4_i <- data$Ei + 0.15



#### A4 ####


# Load the required library
library(data.table)

# Set seed for reproducibility
set.seed(10103)

# Function to generate data

library(data.table)
# Set control and trends values
ctrl <- 0
trends <- "10 11"
# Define the gendata function
gendata <- function(ctrl, trends) {
  # Number of observations
  numobs <- 48
  # Number of treated unit types
  treatedunittypes <- length(unlist(strsplit(trends, " ")))
  # Determine the number of treated and untreated observations
  numtreatedobs <- round(numobs / (1 + ctrl))
  numuntreatedobs <- numobs - numtreatedobs
  # Calculate the number of observations per treated unit type
  obspertype <- floor(numtreatedobs / treatedunittypes)
  # Extract event dates from the trends argument
  eventdates <- as.numeric(strsplit(trends, " ")[[1]])
  # Create data.table
  dt <- data.table(id = 1:numobs)
  # Create treated indicator
  dt[, treated := id > numuntreatedobs]
  # Initialize Ei
  dt[, Ei := as.numeric(NA)]
  # Fill in Ei values based on treated unit types
  for (ii in 1:treatedunittypes) {
    start <- (ii - 1) * obspertype + numuntreatedobs + 1
    stop <- ii * obspertype + numuntreatedobs
    dt[start <= id & id <= stop, Ei := eventdates[ii]]
  }
  # Fill in Ei value for the last treated unit type
  if (max(dt[, id]) > stop) dt[id > stop, Ei := eventdates[treatedunittypes]]
  # Expand time periods
  dt <- dt[, .(treated, Ei, t = 1:20), by = id]
  # Set key for sorting
  setkey(dt, id, t)
  # Make variables that determine the DGP
  dt[, etime := t - Ei]  # Event time
  dt[, TE := ifelse(etime >= 0, etime + 1, 0)]  # Endless ramp function for treatment effect
  dt[is.na(Ei), TE := 0]
  dt[, Y0_pure := 0]  # Simplest counterfactual
  # Other counterfactuals (commented out)
  # dt[, Y0_pure := 4 * treated + 0.3 * treated * t]  # Treated have a pre-trend...
  # dt[, Y0_pure := 4 * treated + 0.1 * treated * (t - 10) * (Ei - 9)]  # Pre-trend based on Ei...
  dt[, eps := sqrt(0.2) * rnorm(n = .N)]
  dt[, actual := Y0_pure + TE * treated]
  dt[, y := actual + eps]  # Observed Y
  return(dt)
}


# Run the gendata function
dt <- gendata(ctrl, trends)


gendata <- function() 
{
  # Set parameters
  numobs <- 48
  treatedunittypes <- length(c(10, 11))
  # Create data
  dt <- data.table(i = 1:numobs)
  # NxT DiD data structure
  dt[, treated := i > 5]
  dt[, Ei := ifelse(treated == 1, 1, 0)]
  dt[, .N, by = .(Ei)] # Display frequencies of Ei for verification
  # Expand time periods
  dt <- dt[, .(Ei, treated, i, t = 1:20), by = i]
  # Make variables that determine the DGP
  dt[, D := (t == Ei)]
  dt[, etime := t - Ei]
  dt[, TE := ifelse(etime >= 0, 1, 0)]
  dt[is.na(Ei), TE := 0]
  dt[, treated_post := etime >= 0]
  dt[, Y0_pure := 0 + 1 * treated]
  dt[, eps := sqrt(0.3) * rnorm(.N)]
  dt[, actual := Y0_pure + TE * treated]
  dt[, y := actual + eps]
  return(dt)
}

# Run the gendata function
dt <- gendata()
# Create variables used for estimation
for (ii in 0:20) {
  dt[, paste("D_p", ii, sep = "") := (etime == ii)]
  dt[, paste("D_m", ii, sep = "") := (etime == -ii)]
  summary(dt[, eval(parse(text=paste0("D_p", ii)))])
  dropme <- mean(dt[, eval(parse(text=paste0("D_p", ii)))], na.rm = T) == 0
  if (dropme) dt <- dt[, (paste("D_p", ii, sep = "")) := NULL]
  summary(dt[, eval(parse(text=paste0("D_m", ii)))])
  dropme <- mean(dt[, eval(parse(text=paste0("D_m", ii)))], na.rm = T) == 0
  if (dropme) dt <- dt[, (paste("D_m", ii, sep = "")) := NULL]
}

dt <- dt[, .SD, .SDcols = !grepl("^D_m0$", names(dt))]  # Drop D_m0
dt[, group2 := Ei == 11]
dt[, trend_group2 := t * group2]
summary(dt)  # Display summary statistics
# Normalize event time -1 to be zero
dt[D_m1 == 1, D_m1 := 0]

# Unit FE's among all average to zero
unit_fe_constraint <- dt[, sum(.SD), .SDcols = grep("^i\\.", names(dt))]
set_constraints <- data.table(constraint_id = c(1, 2),
                              constraint_formula = c("D_m1 = 0", paste(set_constraints, collapse = " + ")))

# Pre-treatment ES dummies average to zero
pre_treatment_constraint <- dt[, sum(.SD), .SDcols = grep("^D_m", names(dt))]
set_constraints <- rbind(set_constraints,
                         data.table(constraint_id = 7,
                                    constraint_formula = paste(pre_treatment_constraint, collapse = " + ")))

# Display constraints
print(set_constraints)

# Run cnsreg with constraints(2 1)
result_ES1 <- cnsreg(y ~ D_m* + D_p* + ibn.t + ibn.i,
                     data = dt,
                     cluster = dt$i,
                     constraints = set_constraints$constraint_formula[set_constraints$constraint_id %in% c(2, 1)],
                     collinear = TRUE)
myb_ES1 <- coef(result_ES1)
myV_ES1 <- vcov(result_ES1)

# Run cnsreg with constraints(2 7)
result_ES2 <- cnsreg(y ~ D_m* + D_p* + ibn.t + ibn.i,
                     data = dt,
                     cluster = dt$i,
                     constraints = set_constraints$constraint_formula[set_constraints$constraint_id %in% c(2, 7)],
                     collinear = TRUE)
myb_ES2 <- coef(result_ES2)
myV_ES2 <- vcov(result_ES2)

# Save the results
main <- copy(dt)  # save main data
save(main, file = tempfile(fileext = ".RData"))

# Get the results ready to plot out
pooled <- data.table()
for (i in 0:10) {
  dt_temp <- data.table(label = c("m", "p"), etime = c(-i, i))
  
  for (j in 1:2) {
    dt_temp[, paste("cf_m", j, sep = "") := NA]
    dt_temp[, paste("truth_m", j, sep = "") := ifelse(j == 1, 0, 1)]
    
    myb <- ifelse(j == 1, myb_ES1, myb_ES2)[grepl(paste("D_m", i, sep = ""), names(myb_ES1))]
    myv <- ifelse(j == 1, myV_ES1, myV_ES2)[grepl(paste("D_m", i, sep = ""), colnames(myV_ES1))]
    myse <- sqrt(myv)
    
    dt_temp[, paste("ES_b_m", j, sep = "") := ifelse(j == 1, myb, 0)]
    dt_temp[, paste("ES_se_m", j, sep = "") := myse]
  }
  
  pooled <- rbind(pooled, dt_temp)
}

# Drop unnecessary labels
pooled <- pooled[!label %in% c("m0", "p10")]

# Sort by etime
pooled <- pooled[order(etime)]

# Save pooled data
save(pooled, file = tempfile(fileext = ".RData"))

# Prepare notes
note1 <- "gam(-1)=0"
note2 <- "Avg(gam(-))=0."

# Plotting
for (i in 1:2) {
  pooled[, paste("top_", i, sep = "") := get(paste("ES_b_m", i, sep = "")) + 1.96 * get(paste("ES_se_m", i, sep = ""))]
  pooled[, paste("bot_", i, sep = "") := get(paste("ES_b_m", i, sep = "")) - 1.96 * get(paste("ES_se_m", i, sep = ""))]

  plot_data <- data.table(etime = pooled$etime,
                          ES_b_m = pooled[, get(paste("ES_b_m", i, sep = ""))],
                          truth_m = pooled[, get(paste("truth_m", i, sep = ""))])
  
  top_col <- paste("top_", i, sep = "")
  bot_col <- paste("bot_", i, sep = "")
  
  plot_data[, c(top_col, bot_col) := .(pooled[, get(top_col)], pooled[, get(bot_col)])]

  # Plotting
  plot_data_long <- melt(plot_data, id.vars = c("etime", "truth_m"))
  plot_data_long[, variable := factor(variable, levels = c("ES_b_m", "top", "bot"))]
  p <- ggplot(plot_data_long, aes(x = etime, y = value, group = variable, color = variable)) +
    geom_line() +
    geom_point(data = plot_data, aes(x = etime, y = ES_b_m, color = NULL)) +
    geom_hline(yintercept = 0, linetype = "dashed") +
    labs(title = paste("Choice of counterfactual normalization impacts CIs: ", i),
         subtitle = paste("`note", i, "'"),
         x = "Event Time",
         y = "Coefficient Estimate") +
    theme_minimal() +
    theme(legend.position = "none")
  
  # Save the plot
  ggsave(filename = paste0("figures/apdx_fig_A0", i, ".png"), plot = p, width = 6, height = 4, units = "in")
}

# Clean up
rm(list = ls(pattern = "dt_"))

# Drop all existing objects
rm(list = ls())

# Define the gendata function
gendata <- function(num_units) {
  # Set up the data table
  dt <- data.table(i = 1:num_units)

  # NxT DiD data structure
  dt[, treated := i > num_units / 2]  # Half of units treated
  dt[, Ei := ifelse(treated == 1, 11, NA)]  # Treatment date

  # Expand time periods
  dt <- dt[, .(i, t = 1:20), by = i]

  # Make variables that determine the DGP
  dt[, D := (t == Ei)]  # The event "pulse"
  dt[, etime := t - Ei]  # Event time
  dt[, TE := ifelse(etime >= 0, 1, 0)]  # Step function treatment effect
  dt[is.na(Ei), TE := 0]

  dt[, treated_post := etime >= 0]

  dt[, Y0_pure := 0 + 1 * treated]  # Offset counterfactual
  dt[, eps := sqrt(0.3) * rnorm(.N)]
  dt[, actual := Y0_pure + TE * treated]
  dt[, y := actual + eps]  # Observed Y

  return(dt)
}

# Set the number of units
num_units <- 10

# Run the gendata function
dt <- gendata(num_units)

# Continue with runme

