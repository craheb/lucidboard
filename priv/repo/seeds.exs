alias Lucidboard.{Repo, Seeds, User}

user = User.new(name: "bob")

Repo.insert!(Seeds.board(user))
Repo.insert!(Seeds.board2(user))
