autoplot.regsubsets <- function(x, 
                                res = c("mallows_cp", "BIC","r.squared","adj.r.squared")
) {
  
  res <- match.arg(res)
  res_sym <- dplyr::ensym(res)
  
  df_params <- broom::tidy(x)
  df_reduced <- df_params %>% 
    dplyr::rowwise() %>% 
    dplyr::mutate(
      # Add Number of Predictors
      pred_no = sum(dplyr::c_across(
        !tidyselect::any_of(c("(Intercept)", "r.squared","adj.r.squared",
                              "BIC","mallows_cp")))), .keep = "unused")  %>% 
    dplyr::ungroup() 
  
  
  ### Find X & Y-Coordinate of the best model 
  #### i.e., lowest point for "mallows_cp", "BIC" and highest point for    "r.squared","adj.r.squared"
  fun <- if(res %in% c("mallows_cp", "BIC")) min else max
  
  best_y <- fun(df_reduced[[res]])
  best_x <- df_reduced %>% 
    dplyr::filter(!!res_sym == fun(!!res_sym)) %>% dplyr::pull(pred_no)
  
  direction_col <- ifelse(res %in% c("mallows_cp", "BIC"), -1, 1)
  
  # Plot
  df_reduced %>%
    ggplot2::ggplot(ggplot2::aes(pred_no, !!res_sym, color = !!res_sym)) +
    ggplot2::geom_point(show.legend = F) +
    ggplot2::geom_line(show.legend = F) +
    ggplot2::scale_color_viridis_c(option = "plasma", end = 0.8, 
                                   direction = direction_col) +
    ggplot2::annotate("point", x = best_x, y = best_y, shape = 4, size = 5, stroke = 0.5)+
    ggplot2::labs(x = "# Predictors") 
  
}