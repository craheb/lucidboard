# Lucidboard

A kanban tool.

**Status:** Just getting started.

**CI:** https://circleci.com/gh/djthread/lucidboard

**Chat:** [Lucidboard on Telegram](http://t.me/lucidboard)

To start your Phoenix development environment:

```bash
bin/dev
```

The [script's comments](bin/dev) explain a bit more, but you'll get two
docker containers -- a Postgres database (`lucidboard_dev_db`) and an Elixir
development container (`lucidboard_dev_app`). The script will then run the
fish shell inside the latter, dropping you into `/app` where the project
files reside.

When running this the first time, you'll need to install the dependencies and
initialize the database. (You may also simply type `setup` since it is an alias
for these commands.)

```bash
mix deps.get
cd assets; npm install; cd ..
mix ecto.setup
```

During `npm install`, Semantic-UI will ask some questions. Answer with `Skip
install`, `Yes`, and then just press enter for the third question to take the
default of `semantic/`.

Finally, start the application with `imp`. This is an alias for `iex -S mix
phx.server` which will run the app with Elixir's interactive repl, iex. This
will allow you to test lines of Elixir code and interact with the running
application. `imp` is the only command you'll need next time, now that things
are installed.

```bash
imp
```

Now you can visit [`localhost:8800`](http://localhost:8800) from your browser.

To close down and remove the docker containers, run the following script.
Don't worry - all your code and database data will remain intact for next
time.

```bash
bin/down
```

## Working with Semantic-UI

The following will be important if you would like to make changes to our
Semantic-UI files.

Changes to files in `assets/css` and `assets/js` will already trigger a live
reload in your browser, but in order for the same to work for the files
inside `assets/semantic`, you'll need to open a dedicated terminal in that
directory and run `gulp watch`. Since Semantic's output files are being
watched by Lucidboard's webpack configuration, live reloading should then
work for these files as well.

## Shell Aliases

These [recommended few](assets/dev-env/config.fish) are imported to the fish
shell in the docker-based dev environment.

| Alias   | Full Command          |
| ------- | --------------------- |
| `imp`   | iex -S mix phx.server |
| `im`    | iex -S mix            |
| `mdg`   | iex mix deps.get      |
| `mdu`   | mix deps.update --all |
| `mt`    | mix test              |
| `mtw`   | mix test.watch        |
| `ml`    | mix lint              |
| `mer`   | mix ecto.reset        |
| `setup` | mix deps.get<br>cd assets; npm install; cd ..<br> mix ecto.setup | 

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
