library(workflowr)
#### Following needs to be run only once per PC
# Replace the example text with your information
# wflow_git_config(user.name = "SeiroIto", user.email = "seiroi@gmail.com", overwrite=TRUE)
#### Following needs to be run only once per project
# wflow_start("c:/data/NameRight", existing = T)
wflow_build()
options(browser = "C:/Program Files (x86)/Google/Chrome/Application/chrome.exe")
#wflow_view()
wflow_status()
## Status of 3 Rmd files
## 
## Totals:
##  3 Unpublished
## 
## The following Rmd files require attention:
## 
## Unp analysis/about.Rmd
## Unp analysis/index.Rmd
## Unp analysis/license.Rmd
## 
## Key: Unp = Unpublished
## 
## The current Git status is:
## 
## The current Git status is:
## 
##     status substatus               file
##   unstaged  modified     _workflowr.yml
##   unstaged  modified analysis/index.Rmd
##  untracked untracked   analysis/program
##  untracked untracked             papers
##  untracked untracked            program
##  untracked untracked           program0
##  untracked untracked               save
##  untracked untracked             source
## 
## To publish your changes as part of your website, use `wflow_publish()`.
## To commit your changes without publishing them yet, use
## `wflow_git_commit()`.
wflow_git_commit(all = T)
wflow_publish(c("analysis/index.Rmd", 
  "analysis/about.Rmd", "analysis/license.Rmd"),
 "Publish the initial files for my test research project.")
## Current working directory: C:/data/NameRight
## Building 3 file(s):
## Building analysis/index.Rmd in C:/data/NameRight/program
## Building analysis/about.Rmd in C:/data/NameRight/program
## Building analysis/license.Rmd in C:/data/NameRight/program
## Summary from wflow_publish
## 
## **Step 1: Commit analysis files**
## 
## No files to commit
## 
## 
## **Step 2: Build HTML files**
## 
## Summary from wflow_build
## 
## Settings:
##  combine: "or" clean_fig_files: TRUE
## 
## The following were built externally each in their own fresh R session: 
## 
## docs/index.html
## docs/about.html
## docs/license.html
## 
## Log files saved in C:\Users\mihot\AppData\Local\Temp\Rtmp6RoGYz/workflowr
## 
## **Step 3: Commit HTML files**
## 
## Summary from wflow_git_commit
## 
## The following was run: 
## 
##   $ git add docs/index.html docs/about.html docs/license.html docs/figure/index.Rmd docs/figure/about.Rmd docs/figure/license.Rmd docs/site_libs docs/.nojekyll 
##   $ git commit -m "Build site." 
## 
## The following file(s) were included in commit 7884cc0:
## docs/about.html
## docs/index.html
## docs/license.html
## docs/site_libs/bootstrap-3.3.5/
## docs/site_libs/header-attrs-2.25/
## docs/site_libs/highlightjs-9.12.0/
## docs/site_libs/jquery-3.6.0/
## docs/site_libs/navigation-1.1/
wflow_use_github("SeiroIto")
## Summary from wflow_use_github():
## account: SeiroIto
## respository: NameRight
## * The website directory is already named docs/
## * Output directory is already set to docs/
## * Set remote "origin" to https://github.com/SeiroIto/NameRight.git
## * Added GitHub link to navigation bar
## * Committed the changes to Git
## 
## To proceed, you have two options:
## 
## 1. Have workflowr attempt to automatically create the repository "NameRight" on GitHub. This requires
## logging into GitHub and enabling the workflowr-oauth-app access to the account "SeiroIto".
## 
## 2. Create the repository "NameRight" yourself by going to https://github.com/new and entering
## "NameRight" for the Repository name. This is the default option.
## 
## Enter your choice (1 or 2): 2
## You chose option 2: create the repo yourself
## To do: Create SeiroIto/NameRight at github.com (if it doesn't already exist)
## To do: Run wflow_git_push() to push your project to GitHub

wflow_git_remote(remote = "origin", user = "SeiroIto", repo = "NameRight",
  protocol = "ssh", action = "set_url")
wflow_git_push(username = "SeiroIto", password = "ProfRepo2022")

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLa4ob1MsitatpoyMzZ1LUh5JxG4PWUGiEMzu6vmjm3EA/3VfOkaoe/DR/swfiurCtN9JNS1XLQ5HcUMIrLD3/2JsV5jHNQMvsxquNGd2vUnYdd3Chwz5aIg81MBZBXvNOg/aEK5F03rEmisbTlKIAwIT/oVQi5mRZVqvWsxwK1KFRMXyCfRfsGvTvaG9ewsJ3snhUxTkVScgNjG4JSPzXIl4ifbmsDbQW1TM2Qa2kryf0u5IBrYNZ+PQ/f/g5qzpqEnrXHybCjD0SHSdCNtj1O6neoGiUTOTXLkzcHulJ8gBMshJ9L3yiUXjKMxk67/beOm/pqhh1OGwMv6LKQFzgdLjUqCu7WLeOBpV+p7cMWwBxx7ciu/jlx6OsMAUzxoPC7eMmNvwSPc7T0Aj55ZdCiWj5ICsL7MUMxMtne627s7H4Agp0i+qtcPRhvHeYDsLShyN4jz7t2D7aQboBIQQ2/xByQfLSKweFvsteNn75rGX0OTQJBoYsH+hRrPGqius= mihot@LAPTOP-NQF56JV9

