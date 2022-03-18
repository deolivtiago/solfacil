# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Solfacil.Repo.insert!(%Solfacil.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Solfacil.Accounts

Accounts.create_user(%{
  name: "Admin",
  email: "admin@mail.com",
  password: "admin",
  admin: true
})

Accounts.create_user(%{
  name: "Tiago de Oliveira",
  email: "tiago@mail.com",
  password: "senhasecreta123"
})

Accounts.create_user(%{
  name: "Eloisa",
  email: "eloisa@mail.com",
  password: "eloisa123"
})
