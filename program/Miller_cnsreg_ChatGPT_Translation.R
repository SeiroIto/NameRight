## This is produced by chat GPT as I asked to translate Miller's 03_apdx_fig_A4.do
## 2024, Jan 13

library(data.table)
library(ggplot2)

# Function to generate data
gendata <- function() {
  set.seed(10103)
  
  # Set up the data.table
  dt <- data.table(i = 1:10)
  dt[, t := rep(1:20, each = 10)]
  
  # Variables determining the DGP
  dt[, D := (t == E_i <- ifelse(i > 5, 11, 10))]
  dt[, etime := t - E_i]
  dt[, TE := ifelse(etime >= 0, 1, 0)]
  
  # Offset counterfactual
  dt[, Y0_pure := 0 + 1 * treated]
  
  # Add treatment effect
  dt[, actual := Y0_pure + TE * treated]
  
  # Add noise
  dt[, eps := sqrt(0.3) * rnorm(1)]
  dt[, y := actual + eps]
  
  return(dt)
}

# Function to run the analysis
runme <- function() {
  # Generate data
  dt <- gendata()
  
  # Create event time dummies
  etime_dummies <- data.table()
  for (i in 0:20) {
    etime_dummies[, paste("D_p", i, sep = "") := (dt$etime == i)]
    etime_dummies[, paste("D_m", i, sep = "") := (dt$etime == -1 * i)]
    
    if (sum(etime_dummies[, get(paste("D_p", i, sep = "")), na.rm = TRUE]) == 0) {
      etime_dummies[, (paste("D_p", i, sep = "")) := NULL]
    }
    if (sum(etime_dummies[, get(paste("D_m", i, sep = "")), na.rm = TRUE]) == 0) {
      etime_dummies[, (paste("D_m", i, sep = "")) := NULL]
    }
  }
  
  # Drop D_m0
  etime_dummies[, (paste("D_m", 0, sep = "")) := NULL]
  
  dt[, group2 := (E_i == 11)]
  dt[, trend_group2 := t * group2]
  
  # Normalize event time -1 to be zero
  dt[!(D_m1 == 0)]
  
  # Unit FE's among all average to zero
  dt[, sum(1.i + 2.i + 3.i + 4.i + 5.i + 6.i + 7.i + 8.i + 9.i + 10.i) == 0]
  
  # Pre-treatment ES dummies average to zero
  dt[, sum(D_m10 + D_m9 + D_m8 + D_m7 + D_m6 + D_m5 + D_m4 + D_m3 + D_m2 + D_m1) == 0]
  
  # Conduct cnsreg analysis
  result_ES1 <- dt[, cnsreg(y, .(D_m1, D_m2, D_m3, D_m4, D_m5, D_m6, D_m7, D_m8, D_m9, D_m10, D_p0, D_p1, D_p2, D_p3, D_p4, D_p5, D_p6, D_p7, D_p8, D_p9, D_p10), 
                              .(ibn.t, ibn.i), cluster = i, constraints = c(2, 1), collinear = TRUE)]
  myb_ES1 <- result_ES1$coefficients
  myV_ES1 <- result_ES1$vcov
  
  result_ES2 <- dt[, cnsreg(y, .(D_m1, D_m2, D_m3, D_m4, D_m5, D_m6, D_m7, D_m8, D_m9, D_m10, D_p0, D_p1, D_p2, D_p3, D_p4, D_p5, D_p6, D_p7, D_p8, D_p9, D_p10), 
                              .(ibn.t, ibn.i), cluster = i, constraints = c(2, 7), collinear = TRUE)]
  myb_ES2 <- result_ES2$coefficients
  myV_ES2 <- result_ES2$vcov
  
  # Save results
  main <- copy(dt)
  
  # Get results ready to plot out
  pooled <- data.table()
  for (i in 0:10) {
    temp_dt <- data.table(
      label = c("m", "p"),
      etime = c(-1 * i, i),
      cf_m1 = rep(NA, 2),
      truth_m1 = c(0, 1),
      ES_b_m1 = rep(NA, 2),
      ES_se_m1 = rep(NA, 2),
      cf_m2 = rep(NA, 2),
      truth_m2 = c(0, 1),
      ES_b_m2 = rep(NA, 2),
      ES_se_m2 = rep(NA, 2)
    )
    
    myb_m1 <- myb_ES1[which(rownames(myb_ES1) == paste("D_m", i, sep = "")), "Estimate"]
    myv_m1 <- myV_ES1[paste("D_m", i, sep = ""), paste("D_m", i, sep = "")]
    myse_m1 <- sqrt(myv_m1)
    temp_dt[cf_m1 == NA, ES_b_m1 := myb_m1, cf_m1 == NA]
    temp_dt[cf_m1 == NA, ES_se_m1 := myse_m1, cf_m1 == NA]
    
    myb_p1 <- myb_ES1[which(rownames(myb_ES1) == paste("D_p", i, sep = "")), "Estimate"]
    myv_p1 <- myV_ES1[paste("D_p", i, sep = ""), paste("D_p", i, sep = "")]
    myse_p1 <- sqrt(myv_p1)
    temp_dt[cf_m1 == NA, ES_b_m1 := myb_p1, cf_m1 == NA]
    temp_dt[cf_m1 == NA, ES_se_m1 := myse_p1, cf_m1 == NA]
    
    myb_m2 <- myb_ES2[which(rownames(myb_ES2) == paste("D_m", i, sep = "")), "Estimate"]
    myv_m2 <- myV_ES2[paste("D_m", i, sep = ""), paste("D_m", i, sep = "")]
    myse_m2 <- sqrt(myv_m2)
    temp_dt[cf_m2 == NA, ES_b_m2 := myb_m2, cf_m2 == NA]
    temp_dt[cf_m2 == NA, ES_se_m2 := myse_m2, cf_m2 == NA]
    
    myb_p2 <- myb_ES2[which(rownames(myb_ES2) == paste("D_p", i, sep = "")), "Estimate"]
    myv_p2 <- myV_ES2[paste("D_p", i, sep = ""), paste("D_p", i, sep = "")]
    myse_p2 <- sqrt(myv_p2)
    temp_dt[cf_m2 == NA, ES_b_m2 := myb_p2, cf_m2 == NA]
    temp_dt[cf_m2 == NA, ES_se_m2 := myse_p2, cf_m2 == NA]
    
    pooled <- rbind(pooled, temp_dt)
  }
  
  # Drop unnecessary rows
  pooled <- pooled[!(label %in% c("m0", "p10"))]
  
  # Sort by etime
  pooled <- pooled[order(etime)]
  
  # Export results
  fwrite(pooled, "pooled.csv")
  
  # Plotting
  for (i in 1:2) {
    top_i <- pooled[, ES_b_m1 + 1.96 * ES_se_m1]
    bot_i <- pooled[, ES_b_m1 - 1.96 * ES_se_m1]
    
    p <- ggplot(pooled, aes(x = etime, y = ES_b_m1)) +
      geom_line(lty = 1, col = "black") +
      geom_line(aes(y = truth_m1), lty = 2, col = "gray") +
      geom_line(aes(y = top_i), lty = 3, col = "brown") +
      geom_line(aes(y = bot_i), lty = 3, col = "brown") +
      geom_hline(yintercept = 0, lty = 2, col = "black") +
      theme_minimal() +
      labs(x = "Event Time", y = "Effect Size", title = paste("Choice of counterfactual normalization impacts CIs: Note", i)) +
      theme(legend.position = "none") +
      ylim(-3, 3.5)
    
    # Save plot
    ggsave(paste("figures/apdx_fig_A04_", i, ".png", sep = ""), p, width = 8, height = 6)
  }
}

# Run the analysis
runme()
