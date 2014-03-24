#' Publish to any folder accessible by the file system
#'
#' @param dirname name of directory to publish to; defaults to slide directory
#' @param html_only if true will only copy html, asset, lib, fig content (no R), else will include all
#' @family publish
#' @export
publish_folder <- function(dirname, html_only=TRUE) {
  if (missing(dirname)){
    dirname = basename(getwd())
  }
  
  pattern = "."
  if(html_only) {
    pattern=".html$|^lib|^fig|^asset"
  }
  
  folder_dir = file.path(dirname)
  message('Creating slide directory at ', folder_dir)
  dir.create(folder_dir)
  message('Copying files to ', folder_dir)
  file_list = list.files(".",pattern)
  file.copy(file_list, folder_dir, overwrite = TRUE, recursive = TRUE)
}