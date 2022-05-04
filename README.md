# Quarto Book Template

My [Quarto book](https://quarto.org/docs/reference/projects/books.html) template and setup for R user.

## If use `R` code

I recommend using [renv package](https://rstudio.github.io/renv/articles/renv.html).

Init

``` r
# install.packages("renv")
renv::init()
```

Snapshot

``` r
renv::snapshot()
```

2 files will be added: `renv.lock` and `renv/`

## If use `Python` code

``` r
renv::use_python(type = "virtualenv")
```

Python virtual environment within project is [recommended](https://rstudio.github.io/renv/reference/use_python.html).

## Continuous Deployment

If you want to render and build site in the cloud using Github Actions.

-   Go to [Quarto Github Actions](https://github.com/quarto-dev/quarto-actions/tree/main/examples)

-   Choose workflow (`.yaml`) file you want, then copy the URL.

-   [`usethis::use_github_action()`](https://usethis.r-lib.org/reference/github_actions.html?q=use_git#use-github-action-) will setup everything in local.

``` r
usethis::use_github_action(url = "url-of-the-yaml")
```

-   If your book using `{renv}`, add this to the workflow file (`.yaml`) before render book.

``` yaml
      # Set up R Environment
      - name: Install R Environment
        uses: r-lib/actions/setup-renv@v2
```

-   You can add `_book` (output dir) to .gitignore and don't need to `render` book before push to Github.

-   Git Push!

(**Note:** If you want to deploy to Netlify, you will need to config 2 Github secrets, [see this](https://github.com/nwtgck/actions-netlify))
