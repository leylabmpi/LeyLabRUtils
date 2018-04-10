#' cCnvert to numeric
#'
#' @param x  a vector or factor
as.Num = function(x){
  as.numeric(as.character(x))
}

#' Simple dataframe summary
#'
#' @param df  dataframe or similar
#' @param n  number of lines to print
status = function(df, n=3){
  df %>% dim %>% print
  df %>% head(n=n)
}

#' make directory if needed
#'
#' @param dir  directory path
make_dir = function(dir){
  if(! dir.exists(dir)){
    dir.create(dir, showWarnings=FALSE)
    cat('Created directory:', dir, '\n')
  } else {
    cat('Directory already exists:', dir, '\n')
  }
}

#' bash job using conda env
#'
#' @param cmd  bash command to run (eg., "ls -thlc")
#' @param conda_env  conda environment name
#' @param conda_path  path to conda executable; if null, then conda assumed to be in your path
#' @param stdout  return stdout?
#' @param stderr  return stderr?
#' @param cat_output  pretty output written to the consol?
bash_job = function(cmd, conda_env=NULL, conda_path=NULL, stdout=TRUE, stderr=FALSE, cat_output=TRUE){
  # formatting command
  if(! is.null(conda_env)){
    cmd = sprintf('source activate %s; %s', conda_env, cmd)
  }
  if(! is.null(conda_path)){
    conda_path = gsub('conda$', '', conda_path)
    cmd = paste(c(sprintf('PATH=%s:$PATH', conda_path), cmd), collapse=';')
  }
  cmd = sprintf('-c "%s"', cmd)

  # system call
  ret = system2('bash', cmd, stdout=stdout, stderr=stderr)

  # returning output
  if (cat_output == TRUE){
    cat(paste(ret, collapse='\n'))
  } else {
    return(ret)
  }
}

